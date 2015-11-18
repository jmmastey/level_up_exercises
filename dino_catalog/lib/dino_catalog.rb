module DinoCatalog
end

require_relative './dino_catalog/dinosaur'
require_relative './dino_catalog/dino_importer'
require_relative './dino_catalog/dinodex'
require_relative './dino_catalog/dino_serializer'
require 'json'
require 'csv'

# dinodex = DinoCatalog::Dinodex.new(DinoCatalog::DinoImporter.new.import_from_csv('lib/dinodex.csv').dinosaur_list)
