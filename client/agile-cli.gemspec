$LOAD_PATH.unshift File.expand_path("lib", __dir__)
require_relative "lib/agile/constants"

Gem::Specification.new do |spec|
  spec.name          = "agile-cli"
  spec.version       = Agile::VERSION
  spec.authors       = ["rubizza-camp"]
  spec.licenses      = ["MIT"]
  spec.summary       = "Command line instrument for agile."
  spec.description   = "Command line instrument for agile. Our git repo https://github.com/rubizza-camp/AgileCli"
  spec.homepage      = "https://github.com/rubizza-camp/AgileCli"
  spec.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  spec.require_paths = ["lib"]
  spec.executables   = ["agile"]

  spec.add_dependency "highline", "~> 2.0.2"
  spec.add_dependency "rainbow", "~> 3.0.0"
  spec.add_dependency "rest-client", "~> 2.0.2"
  spec.add_dependency "terminal-table", "~> 1.8.0"
  spec.add_dependency "thor", "~> 0.20.3"

  spec.add_development_dependency "bundler", "~> 2.0.2"
  spec.add_development_dependency "factory_bot", "~> 5.0.2"
  spec.add_development_dependency "pry", "~> 0.12.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "reek", "~> 5.4.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.74.0"
  spec.add_development_dependency "simplecov", "~> 0.17.0"
  spec.add_development_dependency "timecop", "~> 0.9.1"
end
