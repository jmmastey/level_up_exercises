# coding: utf-8
Gem::Specification.new do |s|
  s.name        = 'dinodex'
  s.version     = '1.0.0'
  s.author      = 'Adam Eberlin'
  s.email       = 'aeberlin@enova.com'
  s.summary     = '...'
  s.description = '...'
  s.homepage    = 'https://github.com/aeberlin/level_up_exercises/tree/master/dino_catalog/source'
  s.license     = 'MIT'

  s.files        = `git ls-files`.split($/)
  s.test_files   = s.files.grep(%r{^spec/})
  s.require_path = 'lib'
end