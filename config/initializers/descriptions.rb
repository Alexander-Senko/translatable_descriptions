ActiveSupport.on_load :model_class do
	include TranslatableDescriptions::Describable if
		reflections[:descriptions] and
			not TranslatableDescriptions::Describable.in? ancestors
end
