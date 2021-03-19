require "jekyll"

module Jekyll
  class TwitchTag < Liquid::Tag
    def initialize(_tag_name, content, _tokens)
      super
      @parsed_url = Jekyll::TwitchTag.parse_twitch_url content
    end

    def render(context)
      host = Jekyll::TwitchTag.site_host context
      %Q(<iframe
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
