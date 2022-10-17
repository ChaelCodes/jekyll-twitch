---
layout: home
---
This Liquid plugin lets you embed Twitch clips in your jekyll sites.

### Usage
1. Add the gem to your Gemfile.
```
group :jekyll_plugins do
  gem 'jekyll-twitch'
end
```
2. Add it the plugin to your `_config.yml`.
```
plugins:
  - jekyll-twitch
```
3. `bundle install` to install your gem.
4. Start your server. `bundle exec jekyll serve --host localhost --port 4000`
5. Embed Twitch on the page!
{% raw %}
```
<div style="width:720px;height:480px">
  {% twitch https://www.twitch.tv/chaelcodes/clip/DeterminedSweetRedpandaDoritosChip-pQiRlDz6rQ9uvuuq %}
</div>
```
{% endraw %}

### Testing in Development

When building your site in development, Jekyll no longer substitutes `site.url` for localhost, which means Twitch embeds will not render. You need to supply host and localhost to view clips in development. `jekyll serve --host localhost --port 4000` This is not an issue in production.

### Deploying using GitHub Pages

If you have custom gems and you're using GitHub pages for your deploys, they will prevent your gems from executing. You need to modify your deploy to use GitHub actions. (This is also the only way to deploy Jekyll 4). You're welcome to use our [deploy setup](.github/workflows/deploy-demo.yml) as an example.
