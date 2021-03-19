# frozen_string_literal: true

require 'jekyll'

# Jekyll Module contains everything Jekyll
module Jekyll
  # Twitch Tag allows you to use twitch as a liquid tag, currently embeds clips
  class TwitchTag < Liquid::Tag
    def initialize(_tag_name, content, _tokens)
      super
      @parsed_url = Jekyll::TwitchTag.parse_twitch_url content
    end

    def render(context)
      host = Jekyll::TwitchTag.site_host context
      %(<iframe
        src="#{@parsed_url}&parent=#{host}"
        height="720"
        width="1280"
        allowfullscreen="true">
      </iframe>)
    end

    # Class Methods
    def self.parse_twitch_url(url)
      url = url.strip
      case url
      when %r{/clip/}
        slug = url.match %r{(?<no>/clip/)(?<clip>.+)}
        "https://clips.twitch.tv/embed?autoplay=false&clip=#{slug[:clip]}"
      end
    end

    def self.site_host(context)
      context.registers[:site].config['host']
    end
  end

  Liquid::Template.register_tag('twitch', Jekyll::TwitchTag)
end
