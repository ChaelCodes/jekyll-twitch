# Jekyll::Twitch

This gem allows you to embed twitch channels, clips, collections, and videos in your Jekyll websites. It adds and registers a new twitch liquid tag that accepts a twitch clip, channel, broadcast, or highlight url. It's based on the [Twitch video embeds](https://dev.twitch.tv/docs/embed/video-and-clips).

`{% twitch https://www.twitch.tv/chaelcodes/clip/SpoopySlipperyGrasshopperPogChamp %}`

## [See the DEMO site](https://www.chael.codes/jekyll-twitch/)
Check out the [demo site](https://www.chael.codes/jekyll-twitch/) for install instructions and to review different embed examples.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jekyll-twitch'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install jekyll-twitch

Then add Jekyll-Twitch to your `_config.yml` like so:
```
plugins:
  - jekyll-twitch
```

## Usage

This is a Jekyll liquid tag, so just put `{% twitch  https://www.twitch.tv/chaelcodes/clip/SpoopySlipperyGrasshopperPogChamp %}` to embed your clip, channel, or broadcast.

When building your site, Jekyll no longer substitutes `site.url` for localhost, which means Twitch embeds will not render. You need to supply host and localhost to view clips in development. `jekyll serve --host localhost --port 4000`

All of the below examples are on the demo site with actual embeds. I strongly recommend using that.

### Channel
This channel embed will show the broadcast while the streamer is live, and the channel offline art when they are not.

```
<div style="width:720px;height:480px">
  {% twitch https://twitch.tv/ChaelCodes %}
</div>
```
### Collection
This embed is used to add a collection of videos to your page or post.

```
<div style="width:720px;height:480px">
  {% twitch https://www.twitch.tv/collections/x5bG2TGTeBYIRg %}
</div>
```
### Clips
This embed is used to add one Twitch clip to your page or post.

```
<div style="width:720px;height:480px">
  {% twitch https://www.twitch.tv/chaelcodes/clip/DeterminedSweetRedpandaDoritosChip-pQiRlDz6rQ9uvuuq %}
</div>
```
### Videos
Whether you call them videos, vods, or higlights, this will embed them in your page or psot.

```
<div style="width:720px;height:480px">
  {% twitch https://www.twitch.tv/videos/716698136 %}
</div>
```

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/ChaelCodes/jekyll-twitch. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ChaelCodes/jekyll-twitch/blob/main/CODE_OF_CONDUCT.md).

For more details on setting up the local environment, demo site, and releasing a new version, see our [CONTRIBUTING.md](/CONTRIBUTING.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Jekyll::Twitch project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ChaelCodes/jekyll-twitch/blob/main/CODE_OF_CONDUCT.md).
