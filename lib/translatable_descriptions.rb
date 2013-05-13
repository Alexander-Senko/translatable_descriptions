require 'translatable_descriptions/engine'

module TranslatableDescriptions
	autoload :Describable, 'translatable_descriptions/describable'

	mattr_accessor :editable_attributes
	self.editable_attributes = [
		:title,
		:abstract,
		:body,
	]
end
