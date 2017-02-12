$LOAD_PATH << '.'

require 'dinosaur'
require 'import'
require 'catalog'
require 'export'

class Dinodex
  @dinosaurs_catalog = Catalog.new
  # 1 import both files
  Import.new(@dinosaurs_catalog)
  # 2.1 Grab all the dinosaurs that were bipeds.
  @dinosaurs_catalog.filter('walking', 'Biped').print_filter
  # # 2.2 Grab all Carnivores
  @dinosaurs_catalog.filter('diet', 'Carnivore').print_filter
  # # 2.3 Grab all from Cretaceous period
  @dinosaurs_catalog.filter('period', 'Cretaceous').print_filter
  # # 2.4 Grab Big or Small
  @dinosaurs_catalog.find_small.print_filter
  @dinosaurs_catalog.find_big.print_filter

  # # 2.5 Combine Criteria
  @dinosaurs_catalog.filter('diet', 'Carnivore').filter('walking', 'Biped') \
    .print_filter
  # # 3 Print all known facts
  @dinosaurs_catalog.print_all
  # # 4 Printer after filter
  @dinosaurs_catalog.filter('period', 'Cretaceous').print_filter
  # # 5 Use a hash to load search parameters
  paras = { diet: 'Carnivore', walking: 'Quadruped', period: 'Cretaceous' }
  @dinosaurs_catalog.search_with_hash(paras).print_filter
  # 6 Convert to JSON
  Export.convert_to_json(@dinosaurs_catalog)
end
