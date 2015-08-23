require 'active_support/concern'

module TranslatableDescriptions::Describable
	extend ActiveSupport::Concern

	included do
		scope :translated, -> (lang = I18n.locale) {
			includes(:descriptions).
				where descriptions: { id: Description.in_language(lang) } # TODO: simplify
		}

		delegate *TranslatableDescriptions.editable_attributes, to: :description

		for lang in I18n.available_locales do
			-> (lang) {
				has_one :"description_#{lang}_relation", -> { where(
					target_type: Description,
					target_id:   Description.in_language(lang)
				)}, reflect_on_association(
					reflect_on_association(:descriptions).options[:through]
				).options

				has_one :"description_#{lang}", reflect_on_association(:descriptions).options.merge({
					through:   :"description_#{lang}_relation",
					dependent: :destroy,
				})

				accepts_nested_attributes_for :"description_#{lang}",
					update_only: true, reject_if: -> (attributes) {
						attributes.values_at(
							*TranslatableDescriptions.editable_attributes
						).reject(&:blank?).blank?
					}

				define_method "build_description_#{lang}" do |attributes = {}|
					descriptions.build attributes.merge(lang: lang)
				end
			}.(lang)
		end
	end

	def description lang = I18n.locale
		send "description_#{lang}" or
			send "build_description_#{lang}"
	end
end
