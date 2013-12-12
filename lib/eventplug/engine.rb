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
require 'compass-rails'

module Eventplug
  class Engine < ::Rails::Engine
    isolate_namespace Eventplug
  end
end
