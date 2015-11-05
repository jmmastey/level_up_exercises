# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'data_science/version'

Gem::Specification.new do |spec|
  spec.name          = 'data_science'
  spec.version       = DataScience::VERSION
  spec.authors       = ['David Rosholt']
  spec.email         = ['drosholt@enova.com']
  spec.homepage      = 'http://example.com'

  spec.summary       = 'Data Science'
  spec.license       = 'Nonstandard'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_development_dependency 'rspec', '~> 3.3', '>= 3.3.0'
  spec.add_development_dependency 'factory_girl', '~> 4.5', '>= 4.5.0'
  spec.add_development_dependency 'mutant', '~> 0.8.7'
  spec.add_development_dependency 'mutant-rspec', '~> 0.8.2'

  spec.add_runtime_dependency 'abanalyzer', '~> 0.1.0'
  spec.add_runtime_dependency 'trollop', '~> 2.1', '>= 2.1.2'
end
