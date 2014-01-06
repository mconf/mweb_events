module MwebEvents
  module EventsHelper

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
