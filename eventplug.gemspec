$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "eventplug/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "eventplug"
  s.version     = Eventplug::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Eventplug."
  s.description = "TODO: Description of Eventplug."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '~> 3.2.15'
  s.add_dependency 'sass-rails', '~> 3.2.3'
  s.add_dependency 'coffee-rails', '~> 3.2.1'
  s.add_dependency 'simple_form', '~> 2.1.0'
  s.add_dependency 'haml'
  s.add_dependency 'haml-rails'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'epic-editor-rails'
  s.add_dependency 'leaflet-rails'
  s.add_dependency 'geocoder'
  s.add_dependency 'redcarpet'
  s.add_dependency 'therubyracer'
  s.add_dependency 'less-rails'
  s.add_dependency 'twitter-bootstrap-rails'
  s.add_dependency 'compass-rails', '~> 1.0'

  s.add_development_dependency 'sqlite3'
end
