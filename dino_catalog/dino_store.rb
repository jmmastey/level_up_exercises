
# dinodex
# name, period, continent, diet, weight_in_lbs, walking, description

# african_dinosaur_export
# genus, period, carnivore, weight, walking

# load file x
# parse csv x
# see database contents x
# search by walking, diet, periods, small or big, or combine
# look at each dinosaur x
# show reults from search/filter x
# search by parameters
# export json

require 'csv'

$LOAD_PATH << '.'

require 'dinosaur'
require 'import'
require 'catalog'
require 'export'

class Dinodex
  @dinosaurs_catalog = Catalog.new
  Import.new(@dinosaurs_catalog)
  puts @dinosaurs_catalog.items[0].to_s
  @dinosaurs_catalog.print_all
  @dinosaurs_catalog.find_one('Giganotosaurus')
  @dinosaurs_catalog.filter('walking', 'Biped')
  @dinosaurs_catalog.filter('diet', 'Carnivore')
  @dinosaurs_catalog.filter('diet', 'Carnivore').filter('walking', 'Biped').print_filter
  Export.convert_to_json(@dinosaurs_catalog)
end

# d = Dinodex.new('dinodex.csv')
# d.print_all
# p d.columns
# p d.find('Giganotosaurus')
# d.select('diet', 'Carnivore')
