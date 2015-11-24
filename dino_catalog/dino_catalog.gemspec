Gem::Specification.new do |s|
  s.name = 'dino_catalog'
  s.version = '0.0.0'
  s.date = '2015-11-15'
  s.summary = 'Dino Catalog'
  s.description = 'Import Dinosaur data and filter by parameters.'
  s.authors = ['Chris Stavitsky']
  s.email = 'cstavitsky@enova.com'
  s.files = [
    'lib/dino_catalog.rb',
    'lib/dinodex.csv',
    'lib/african_dinosaur_export.csv',
    'lib/dino_catalog/dino_importer.rb',
    'lib/dino_catalog/dinodex.rb',
    'lib/dino_catalog/dinosaur.rb',
    'lib/dino_catalog/dino_serializer.rb',
  ]
  s.license = 'MIT'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry'
end
