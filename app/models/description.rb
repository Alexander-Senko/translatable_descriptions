class Description < ActiveRecord::Base
	scope :in_language, -> (lang = I18n.locale) {
		where lang: lang
	}
end
