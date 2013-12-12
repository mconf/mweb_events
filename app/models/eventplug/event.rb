module Eventplug
  class Event < ActiveRecord::Base
    attr_accessible :address, :date, :description, :location, :name

    geocoded_by :address
    after_validation :geocode

    belongs_to :owner
    has_many :participants

    def description_html
      if description
        require 'redcarpet'
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
        html = markdown.render description
      else
        html = t('event.no_description')
      end

      html
    end

  end
end
