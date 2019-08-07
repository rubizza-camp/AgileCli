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

  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "reek"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "simplecov"
end