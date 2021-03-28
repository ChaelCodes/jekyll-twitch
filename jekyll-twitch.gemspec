# frozen_string_literal: true

require_relative 'lib/jekyll-twitch/version'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-twitch'
  spec.version       = Jekyll::Twitch::VERSION
  spec.authors       = ['Rachael Wright-Munn']
  spec.email         = ['chaelcodes@gmail.com']

  spec.summary       = 'Embed Twitch clips, VODs, and broadcasts in your Jekyll sites.'
  spec.description   = 'A gem that creates a TwitchTag liquid tag that allows Jekyll sites ' \
                       'to render Twitch clips, VODs, and broadcasts.'
  spec.homepage      = 'https://github.com/ChaelCodes/jekyll-twitch'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  # spec.metadata["allowed_push_host"] = "" # Used for private gem server

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ChaelCodes/jekyll-twitch'
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'jekyll'
end
