# frozen_string_literal: true

require 'jekyll'

# These are all for Jekyll.
module Jekyll
  # This is a liquid tag that embed Twitch Clips
  # input is a url
  class TwitchTag < Liquid::Tag
    def initialize(_tag_name, content, _tokens)
      super
      @parsed_url = Jekyll::TwitchTag.parse_twitch_url content.strip
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
    def self.channel_url(url)
      slug = url.match %r{(?<no>twitch.tv/)(?<channel>.+)/?\??}
      "https://player.twitch.tv/?channel=#{slug[:channel]}&autoplay=false"
    end

    def self.clip_url(url)
      slug = url.match %r{(?<no>/clip/)(?<clip>.+)/?\??}
      "https://clips.twitch.tv/embed?autoplay=false&clip=#{slug[:clip]}"
    end

    def self.collection_url(url)
      slug = url.match %r{(?<no>/collections/)(?<collection>.+)/?\??}
      "https://player.twitch.tv/?collection=#{slug[:collection]}&autoplay=false"
    end

    def self.hostname(url)
      matches = url.match %r{\A(?<safe>https?://)?(?<host>[A-z.]+)(?<port>:\d+)?}
      matches[:host]
    end

    def self.parse_twitch_url(url)
      case url
      when %r{/clip/}
        clip_url url
      when %r{/videos/}
        video_url url
      when %r{/collections/}
        collection_url url
      else
        channel_url url
      end
    end

    def self.site_url(context)
      hostname(context.registers[:site].config['url'])
    end

    def self.video_url(url)
      slug = url.match %r{(?<no>/videos/)(?<vod>\d+)}
      "https://player.twitch.tv/?video=#{slug[:vod]}&autoplay=false"
    end
  end

  Liquid::Template.register_tag('twitch', Jekyll::TwitchTag)
end
