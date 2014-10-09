# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eve_central/version'

Gem::Specification.new do |spec|
  spec.name          = "eve_central"
  spec.version       = EveCentral::VERSION
  spec.authors       = ["Dan Kotowski"]
  spec.email         = ["dkotowski@enova.com"]
  spec.summary       = %q{Makes calls against EVE Central's web API.}

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-collection_matchers"
  spec.add_development_dependency "rubysl-irb"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_runtime_dependency "nokogiri"
end
