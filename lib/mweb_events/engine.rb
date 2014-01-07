require 'rails'
require 'coffee-rails'
require 'sass/rails'
require 'haml-rails'
require 'simple_form'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'epic-editor-rails'
require 'leaflet-rails'
require 'geocoder'
require 'less-rails'
require 'twitter-bootstrap-rails'
require 'bootstrap-datetimepicker-rails'
require 'font-awesome-rails'
require 'compass-rails'
require 'icalendar'

module MwebEvents
  class Engine < ::Rails::Engine
    isolate_namespace MwebEvents

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

  end
end
