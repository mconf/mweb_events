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
      end_on.in_time_zone(time_zone) if end_on && time_zone
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

    # Events that are either in the future or are running now.
    scope :upcoming, lambda {
      where("end_on > ?", Time.now).order("start_on")
    }

    # Returns whether the event is happening now or not.
    def is_happening_now?
      if start_on.past? && end_on.future?
        true
      else
        false
      end
    end

    # Returns whether the event will happen in the future or not.
    def future?
      start_date.future?
    end

    # Returns a string with the starting hour of an event in the correct format
    def get_formatted_hour
      start_on.strftime("%H:%M")
    end

    # Returns a string with the starting date of an event in the correct format
    def get_formatted_date(date=nil)
      if date.nil?
        I18n::localize(start_on, :format => "%A, %d %b %Y, %H:%M (#{get_formatted_timezone})")
      else
        I18n::localize(date, :format => "%A, %d %b %Y, %H:%M (#{get_formatted_timezone(date)})")
      end
    end

    def get_formatted_timezone(date=nil)
      if date.nil?
        "GMT#{start_on.formatted_offset}"
      else
        "GMT#{date.formatted_offset}"
      end
    end

  end
end
