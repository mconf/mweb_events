module MwebEvents
  class Event < ActiveRecord::Base
    attr_accessible :address, :start_on, :end_on, :description, :location, :name, :time_zone

    geocoded_by :address
    after_validation :geocode

    belongs_to :owner, :polymorphic => true
    has_many :participants

    validates :name, :presence => true
    validates :start_on, :presence => true

    def description_html
      if not description.blank?
        require 'redcarpet'
        markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
        html = markdown.render description
      else
        html = I18n.t('mweb_events.events.no_description')
      end

      html
    end

    def summary
      ''
    end

    def permalink
      ''
    end

    def start_on_with_time_zone
      start_on.in_time_zone(time_zone) if start_on && time_zone
    end

    def end_on_with_time_zone
      end_on.in_time_zone(time_zone) if start_on && time_zone
    end

    def to_ics
      event = Icalendar::Event.new
      event.start = self.start_on.strftime("%Y%m%dT%H%M%S")
      event.end = self.end_on.strftime("%Y%m%dT%H%M%S")
      event.summary = self.name
      event.description = self.summary
      event.location = self.location
      event.klass = "PUBLIC"
      event.created = self.created_at
      event.last_modified = self.updated_at
      event.uid = event.url = self.permalink
      event.add_comment("")
      event
    end
  end
end
