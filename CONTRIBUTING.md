# Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/ChaelCodes/jekyll-twitch. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ChaelCodes/jekyll-twitch/blob/main/CODE_OF_CONDUCT.md).

## Gem Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Demo Site Development
Jekyll-Twitch has a demo site for testing and demonstrating its capabilities. It is located in [docs](/docs) and deployed via [GitHub Actions](.github/workflows/deploy-demo.yml) to GitHub Pages. It uses the copy of jekyll-twitch available on main, but can be customized to look at a specific branch in the [Gemfile](docs/Gemfile).

### Run it locally

1. navigate to the docs directory `cd docs`
1. `bundle install` Installs all gems and dependencies according to Gemfile.lock
1. `bundle update jekyll-twitch` Updates Jekyll-twitch to the newest version from main
1. `bundle exec jekyll serve --host localhost --port 4000` Run the server - we need the port and host for Twitch's embeds

Website should be up and running at [http://localhost:4000/jekyll-twitch/](http://localhost:4000/jekyll-twitch/)

You will need to rerun steps 3 and 4 whenever there are changes on main or pushed to your branch that you want to test on the site.

## Release a new Version
- Ensure all desired changes are merged to the `main` branch
- checkout a branch with the version number eg. `git checkout -b 1.0.1`
- Update the version number in [version.rb](lib/jekyll-twitch/version.rb)
   - We use [semantic versioning](https://semver.org/)
- Add a new post to the demo site describing the changes, and linking to the PRs that changed them
- `bundle update jekyll-twitch` on the docs site to get the newest changes from `main`
- Test `main` on the demo site
- Run `bundle exec rake release`
   - This will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).