ActiveSupport.on_load :model_class do
	include TranslatableDescriptions::Describable if
		reflect_on_association(:descriptions) and
			not TranslatableDescriptions::Describable.in? ancestors
end
