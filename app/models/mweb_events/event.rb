module MwebEvents
  class Event < ActiveRecord::Base
    extend FriendlyId

    attr_accessible :address, :start_on_time, :start_on_date, :description,
      :location, :name, :time_zone, :end_on_time, :end_on_date,
      :social_networks, :summary, :owner_id, :owner_type, :start_on, :end_on

    attr_accessor :start_on_time, :start_on_date, :end_on_time, :end_on_date

    geocoded_by :address
    after_validation :geocode

    belongs_to :owner, :polymorphic => true
    has_many :participants, :dependent => :destroy

    validates :name, :presence => true
    validates :start_on, :presence => true
    validates :time_zone, :presence => true
    validates :summary, :length => {:maximum => 140}

    friendly_id :name, use: :slugged, :slug_column => :permalink
    validates :permalink, :presence => true

    # If the event has no ending date, use a day from start date
    before_save :check_end_on
    before_validation :check_summary

    # Test if we need to clear the coordinates because address was cleared
    before_save :check_coordinates

    before_save :convert_dates_to_utc

    # Events that are happening currently
    scope :happening_now, lambda {
      where("start_on <= ? AND end_on > ?", Time.zone.now, Time.zone.now).order("start_on")
    }

    # Events that have already happened
    scope :past, lambda {
      where("end_on < ?", Time.zone.now).order("end_on")
    }

    # Events that are either in the future or are running now.
    scope :upcoming, lambda {
      where("end_on > ?", Time.zone.now).order("start_on")
    }

    # Events that happen between `from` and `to`
    scope :within, lambda { |from, to|
      where("(start_on >= ? AND start_on <= ?) OR (end_on >= ? AND end_on <= ?)", from, to, from, to)
    }

    # For form pretty display only
    attr_accessor :owner_name
    def owner_name
      @owner_name || owner.try(:name) || owner.try(:email)
    end

    # Override this method to get a correct url in production
    def self.host
      "example.com"
    end

    def full_url
      MwebEvents::Engine.routes.url_helpers.event_path(self, :host => Event.host, :only_path => false)
    end

    def should_generate_new_friendly_id?
      new_record?
    end

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

    def social_networks=(networks)
      write_attribute(:social_networks , networks.select{|n| !n.empty?}.join(','))
    end

    def social_networks
      networks = read_attribute(:social_networks)
      networks ? networks.split(',') : []
    end

    def start_on_with_time_zone
      start_on.in_time_zone(time_zone) if start_on && time_zone
    end

    def end_on_with_time_zone
      end_on.in_time_zone(time_zone) if end_on && time_zone
    end

    # To format results on forms
    def start_on_date
      start_on_with_time_zone.strftime('%d/%m/%Y') if start_on
    end

    def start_on_time
      start_on_with_time_zone.strftime('%H:%M') if start_on
    end

    def end_on_date
      end_on_with_time_zone.strftime('%d/%m/%Y') if end_on
    end

    def end_on_time
      end_on_with_time_zone.strftime('%H:%M') if end_on
    end

    def to_ics
      event = Icalendar::Event.new
      event.dtstart = start_on.strftime("%Y%m%dT%H%M%SZ")
      event.dtend = end_on.strftime("%Y%m%dT%H%M%SZ") if !end_on.blank?
      event.summary = name
      event.organizer = owner_name
      event.description = summary
      event.location = "#{location}"
      event.location += " - #{address}" if !address.blank?
      event.klass = "PUBLIC"
      event.created = created_at.strftime("%Y%m%dT%H%M%S")
      event.last_modified = updated_at.strftime("%Y%m%dT%H%M%S")
      event.uid = full_url
      event.url = full_url
      event.add_comment summary
      event
    end

    # Returns wheter the event has already happaned and is finished
    def past?
      end_on.past?
    end

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
    def get_formatted_date(date=nil, with_tz=true)
      if date.nil?
        if with_tz
          I18n::localize(start_on, :format => "%A, %d %b %Y, %H:%M (#{get_formatted_timezone})")
        else
          I18n::localize(start_on, :format => "%A, %d %b %Y, %H:%M")
        end
      else
        if with_tz
          I18n::localize(date, :format => "%A, %d %b %Y, %H:%M (#{get_formatted_timezone(date)})")
        else
          I18n::localize(date, :format => "%A, %d %b %Y, %H:%M")
        end
      end
    end

    def get_formatted_timezone(date=nil)
      if date.nil?
        "GMT#{start_on_with_time_zone.formatted_offset}"
      else
        "GMT#{date.in_time_zone(time_zone).formatted_offset}"
      end
    end

    # We store dates as UTC and convert to show and receive input
    def convert_dates_to_utc
      Time.use_zone time_zone do
        write_attribute(:start_on,
          Time.zone.parse(start_on.strftime("%d/%m/%Y %H:%M")).in_time_zone('UTC')) if time_zone_changed? || start_on_changed?
        write_attribute(:end_on,
          Time.zone.parse(end_on.strftime("%d/%m/%Y %H:%M")).in_time_zone('UTC')) if time_zone_changed? || end_on_changed?
      end
    end

    def check_end_on
      write_attribute(:end_on, start_on + 1.day) if end_on.blank?
    end

    def check_summary
      if summary.blank?
        s = HTML::FullSanitizer.new.sanitize(description_html).truncate(136, :omission => '...')
        write_attribute(:summary, s)
      end
    end

    def check_coordinates
      if persisted? && address.blank?
        write_attribute(:longitude, nil)
        write_attribute(:latitude, nil)
      end
    end
  end
end
