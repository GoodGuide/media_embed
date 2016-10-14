module MediaEmbed
  module Handler
    extend self

    CODE = -1

    def embed(url, options = {})
      template_for(url, options)
    end

    def youtube?(url)
      url.match youtube_regex
    end

    def vimeo?(url)
      url.match vimeo_regex
    end

    def soundcloud?(url)
      url.match soundcloud_regex
    end

    def metacafe?(url)
      url.match metacafe_regex
    end

    def video?(url)
      youtube?(url) ||
        vimeo?(url) ||
        metacafe?(url)
    end

    protected

    def template_for(url, options = {})
      if match = youtube?(url)
        Video.youtube_template(match[CODE], options)
      elsif match = vimeo?(url)
        Video.vimeo_template(match[CODE], options)
      elsif match = soundcloud?(url)
        Podcast.soundcloud_template(match[CODE], options)
      elsif match = metacafe?(url)
        Video.metacafe_template(match[CODE], options)
      else
        ''
      end
    end

    def youtube_regex
      %r{youtu(\.be|be\.com)/(watch\?v=|embed/|)([^?\s]*)}
    end

    def vimeo_regex
      %r{vimeo\.com/(channels/\D*|groups/\D*|album/\d*/video/|video/|)([^?\s]*)}
    end

    def soundcloud_regex
      %r{soundcloud.com/(.*/[a-zA-Z0-9\-\_]*)}
    end

    def metacafe_regex
      %r{metacafe.com/watch/(.*\/[a-zA-Z0-9\-\_]*)}
    end
  end
end
