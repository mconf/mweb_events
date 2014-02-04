$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mweb_events/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mweb_events"
  s.version     = MwebEvents::VERSION
  s.authors     = ["Lucas Zawacki", "mconf"]
  s.email       = ["lfzawacki@mconf.com"]
  s.homepage    = "http://github.com/mconf/mweb-events"
  s.summary     = "Summary of MwebEvents."
  s.description = "Description of MwebEvents."

  s.files = Dir["{app,config,db,lib,vendor}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails', '~> 3.2.0'
  s.add_dependency 'sass-rails', '~> 3.2.3'
  s.add_dependency 'coffee-rails', '~> 3.2.1'
  s.add_dependency 'simple_form', '~> 2.1.0'
  s.add_dependency 'haml'
  s.add_dependency 'haml-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'select2-rails'
  s.add_dependency 'epic-editor-rails'
  s.add_dependency 'leaflet-rails'
  s.add_dependency 'geocoder'
  s.add_dependency 'redcarpet'
  s.add_dependency 'therubyracer'
  s.add_dependency 'less-rails'
  s.add_dependency 'twitter-bootstrap-rails'
  s.add_dependency 'bootstrap-datetimepicker-rails'
  s.add_dependency 'font-awesome-rails', '~> 3.2'
  s.add_dependency 'compass-rails', '~> 1.0'
  s.add_dependency 'icalendar'
  s.add_dependency 'cancan'
  s.add_dependency 'friendly_id'
  s.add_dependency 'valid_email'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
end
