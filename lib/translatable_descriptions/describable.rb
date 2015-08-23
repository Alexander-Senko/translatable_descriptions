require 'active_support/concern'

module TranslatableDescriptions::Describable
	extend ActiveSupport::Concern

	included do
		scope :translated, -> (lang = I18n.locale) {
			includes(:descriptions).
				where descriptions: { id: Description.in_language(lang) } # TODO: simplify
		}

		delegate *TranslatableDescriptions.editable_attributes, to: :description

		I18n.available_locales.each &method(:attach_descriptions)
	end

	module ClassMethods
		private

		def attach_descriptions lang = nil
			association_name         = ([ 'description', lang ].compact * '_').to_sym
			through_association_name = :description_relation

			has_one through_association_name, reflect_on_association(
				reflect_on_association(:descriptions).options[:through]
			).options unless
				reflect_on_association through_association_name

			has_one association_name, -> { where(
				lang: lang || I18n.locale
			)}, reflect_on_association(:descriptions).options.merge({
				through:   through_association_name,
				dependent: :destroy,
			})

			accepts_nested_attributes_for association_name,
				update_only: true, reject_if: -> (attributes) {
					attributes.values_at(
						*TranslatableDescriptions.editable_attributes
					).reject(&:blank?).blank?
				}

			define_method "build_#{association_name}" do |attributes = {}|
				descriptions.build attributes.merge(
					lang: lang || I18n.locale
				)
			end
		end
	end

	def description lang = I18n.locale
		send "description_#{lang}" or
			send "build_description_#{lang}"
	end
end
