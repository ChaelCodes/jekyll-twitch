## Description


## Steps For Releasing New Gem Version
- Ensure all desired changes are merged to the `main` branch
- checkout a branch with the version number eg. `git checkout -b 1.0.1`
- Update the version number in [version.rb](lib/jekyll-twitch/version.rb)
   - We use [semantic versioning](https://semver.org/)
- Add a new post to the demo site describing the changes, and linking to the PRs that changed them
- `bundle update jekyll-twitch` on the docs site to get the newest changes from `main`
- Test `main` on the demo site
- Run `bundle exec rake release`
   - This will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
