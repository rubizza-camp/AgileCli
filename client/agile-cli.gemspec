$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "agile-cli"
  spec.version       = '0.0.2'
  spec.authors       = ["rubizza-camp"]
  spec.licenses      = ['MIT']
  spec.summary       = %q{Command line instrument for agile.}
  spec.description   = %q{Command line instrument for agile.}
  spec.homepage      = "https://github.com/rubizza-camp/AgileCli"
  spec.files         = `git ls-files`.split($\)
  spec.require_paths = ['lib']
  spec.executables   = ['agile']

  spec.add_dependency 'thor'

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
