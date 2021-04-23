# frozen_string_literal: true

require 'jekyll'

# These are all for Jekyll.
module Jekyll
  # This is a liquid tag that embed Twitch Clips
  # input is a url
  class TwitchTag < Liquid::Tag
    def initialize(_tag_name, content, _tokens)
      super
      @parsed_url = Jekyll::TwitchTag.parse_twitch_url content
    end

    def render(context)
      host = Jekyll::TwitchTag.site_url context
      %(<iframe
        src="#{@parsed_url}&parent=#{host}"
        height="100%"
        width="100%"
        allowfullscreen="true">
      </iframe>)
    end

    # Class Methods
    def self.hostname(url)
      matches = url.match %r{\A(?<safe>https?://)?(?<host>[A-z.]+)(?<port>:\d+)?}
      matches[:host]
    end

    def self.parse_twitch_url(url)
      url = url.strip
      case url
      when %r{/clip/}
        slug = url.match %r{(?<no>/clip/)(?<clip>.+)}
        "https://clips.twitch.tv/embed?autoplay=false&clip=#{slug[:clip]}"
      else
        slug = url.match %r{(?<no>twitch.tv/)(?<channel>.+)/?}
        "https://player.twitch.tv/?channel=#{slug[:channel]}&autoplay=false"
      end
    end

    def self.site_url(context)
      hostname(context.registers[:site].config['url'])
    end
  end

  Liquid::Template.register_tag('twitch', Jekyll::TwitchTag)
end
