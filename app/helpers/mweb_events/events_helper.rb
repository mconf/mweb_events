module MwebEvents
  module EventsHelper

    def event_logo(event, options={})
      options[:class] = "#{options[:class]} mweb_events-event-logo" # disabled tooltipped upwards
      options[:title] = 'title'
      options[:href] = mweb_events.event_path(event)

      day = content_tag(:div, sanitize(event.start_on.strftime("%d")), { :class => 'mweb_events-event-logo-day' })
      month = content_tag(:div, localize(event.start_on, :format => "%b"), { :class => 'mweb_events-event-logo-month' })
      hour = content_tag(:div, event.get_formatted_hour, { :class => 'mweb_events-event-logo-hour' })
      content_tag(:a, day + month + hour, options)
    end

    def button_url type
      case type
        when 'Google Plus' then googleplus_button_url
        when 'Twitter' then twitter_button_url
        when 'Facebook' then facebook_button_url
        when 'Linkedin' then linkedin_button_url
      end
    end

    def linkedin_button_url
      title = CGI.escape(@event.name)
      summary = CGI.escape(@event.description)
      url = CGI.escape(request.original_url)
      "http://www.linkedin.com/shareArticle?mini=true&url=#{url}&summary=#{summary}&title=#{title}&source=Mconf Events"
    end

    def googleplus_button_url
      "https://plus.google.com/share?url=#{CGI.escape(request.original_url)}"
    end

    def twitter_button_url
      text = I18n.t('mweb_events.events.social_media.twitter_link', :url => CGI.escape(request.original_url))
     "https://twitter.com/intent/tweet?text=#{text}"
    end

    def facebook_button_url
      url = CGI.escape(request.original_url)
      text = I18n.t('mweb_events.events.social_media.facebook_link', :url => url)
      "https://www.facebook.com/sharer/sharer.php?u=#{url}&t=#{text}"
    end

  end
end
