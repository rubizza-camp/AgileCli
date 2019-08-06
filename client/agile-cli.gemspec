
# lib = File.expand_path("../lib", __FILE__)
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
# require "agile/constants"

Gem::Specification.new do |spec|
  spec.name          = "agile-cli"
  spec.version       = '0.0.1'
  spec.authors       = ["rubizza-camp"]
  spec.licenses      = ['MIT']
  spec.summary       = %q{Command line instrument for agile.}
  spec.description   = %q{Command line instrument for agile.}
  spec.homepage      = "https://github.com/rubizza-camp/AgileCli"
  spec.files       = ["lib/"]

  spec.add_dependency 'thor'

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
