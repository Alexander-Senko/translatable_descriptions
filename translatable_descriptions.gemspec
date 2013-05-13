$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'translatable_descriptions/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
	s.name        = 'translatable_descriptions'
	s.version     = TranslatableDescriptions::VERSION
	s.authors     = [ 'Alexander Senko' ]
	s.email       = [ 'Alexander.Senko@gmail.com' ]
	s.homepage    = 'TODO'
	s.summary     = 'TODO: Summary of TranslatableDescriptions.'
	s.description = 'TODO: Description of TranslatableDescriptions.'

	s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

	s.add_dependency 'rails', '~> 4.0.0.rc'

	s.add_development_dependency 'sqlite3'
end
