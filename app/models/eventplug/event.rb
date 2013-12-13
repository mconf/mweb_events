module Eventplug
  class Event < ActiveRecord::Base
    attr_accessible :address, :date, :description, :location, :name

    geocoded_by :address
    after_validation :geocode

    belongs_to :owner
    has_many :participants

    validates :name, :presence => true
    validates :date, :presence => true

    def description_html
      if not description.blank?
        require 'redcarpet'
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
        html = markdown.render description
      else
        html = I18n.t('eventplug.events.no_description')
      end

      html
    end

  end
end
