require_relative "lib/mapawynajmu_pl/version"

Gem::Specification.new do |spec|
  spec.name        = "mapawynajmu_pl"
  spec.version     = MapawynajmuPl::VERSION
  spec.authors     = ["tom-ash"]
  spec.email       = ["tomasz.bogusz@outlook.com"]
  # spec.homepage    = "TODO"
  spec.summary     = ""
  # spec.description = "TODO: Description of MapawynajmuPl."
  spec.license     = ""

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.add_dependency "rails", "~> 7.0.4.3"
end
