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

  s.add_dependency 'rails', '~> 4.1.4'
  s.add_dependency 'sass-rails', '>= 4.0.0'
  s.add_dependency 'coffee-rails', '>= 4.0.0'
  s.add_dependency 'simple_form', '~> 3.0.0'
  s.add_dependency 'haml'
  s.add_dependency 'haml-rails'
  s.add_dependency 'jquery-rails', '~> 3.1.1'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'select2-rails'
  s.add_dependency 'epic-editor-rails'
  s.add_dependency 'leaflet-rails'
  s.add_dependency 'geocoder'
  s.add_dependency 'redcarpet'
  s.add_dependency 'therubyracer'
  s.add_dependency 'less-rails'
  s.add_dependency 'twitter-bootstrap-rails'
  s.add_dependency 'font-awesome-rails', '~> 4.1.0.0'
  s.add_dependency 'compass-rails', '~> 1.0'
  s.add_dependency 'icalendar'
  s.add_dependency 'cancancan', '~> 1.8'
  s.add_dependency 'friendly_id'
  s.add_dependency 'valid_email'
  s.add_dependency 'momentjs-rails', '~> 2.5.0'
  s.add_dependency 'bootstrap3-datetimepicker-rails', '~> 3.0.0'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
end
