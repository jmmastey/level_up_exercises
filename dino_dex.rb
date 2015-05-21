# DinoDex is the main class
require 'csv'
require_relative 'dinosaur.rb'
# DinoDex is the main class
class DinoDex
  SIZE_VALUE = 4000
  NAME_CONVERTER = lambda do |field|
    field = 'NAME' if field == 'Genus'
    field
  end

  DIET_CONVERTER = lambda do |field|
    field = 'DIET' if field == 'Carnivore'
    field
  end

  WEIGHT_CONVERTER = lambda do |field|
    field = 'WEIGHT_IN_LBS' if field == 'Weight'
    field
  end

  CONVERTERS = [DIET_CONVERTER, WEIGHT_CONVERTER, NAME_CONVERTER, :downcase]
  def initialize(name_csv)
    @dinosaurs = []
    CSV.foreach(name_csv,
                headers: true,
                header_converters: CONVERTERS
               )do |row|
      a = Dinosaur.new(row.to_hash)
      @dinosaurs << a
    end
  end

  def find_simple(attrb, value)
    result = @dinosaurs.select { |dino| dino.simple_filter?(attrb, value) }
    puts result.to_s
    Dinosaur.new(result.to_s)
  end

  def find_carnivore(attrb, value)
    result = @dinosaurs.select { |dino| dino.carnivore?(attrb, value) }
    puts result.to_s
    Dinosaur.new(result.to_s)
  end

  def find_big
    result = @dinosaurs.select { |dino| dino.big? }
    puts result.to_s
    Dinosaur.new(result.to_s)
  end

  def find_small
    result = @dinosaurs.select { |dino| dino.small? }
    puts result.to_s
    Dinosaur.new(result.to_s)
  end
end
# Just uncomment any condition/filter you want to test.
dino_dex = DinoDex.new('dinodex.csv')
dino_dex.find_carnivore(:diet, (MEAT_EATERS))

# Grab all dinosaurs that were carnivores
# and grab all dinosaurs who ate fish and insect
MEAT_EATERS = %w(Carnivore Insectivore Piscivore)
dino_dex.find_carnivore(:diet, (MEAT_EATERS))

# Grab all dinosars that were bipeds
dino_dex.find_simple(:walking, 'Biped')

# Grab dinosaurs for specific periods(no need to
# differentiate between Early and Late Cretaceous)
dino_dex.find_simple(:period, 'Late Cretaceous')

# Grab all dinosaurs that are big
dino_dex.find_big

# Grab all dinosaurs that are small
dino_dex.find_small

# can handle the african dinos
dino_dex = DinoDex.new('african_dinosaur_export.csv')
dino_dex.find_simple(:period, 'Jurassic')

# Combine criteria, you can select big and another criteria
dino_dex.find_big.simple_filter?(:walking, 'Bipded')

# Combine criteria, you can select small and another criteria
dino_dex.find_small.simple_filter?(:walking, 'Bipded')

# Combine Criteria,  you can select carnivore and any other criteria
dino_dex.find_simple(:walking, 'Biped').carnivore?(:diet, %w(MEAT_EATERS))

# For a given dino,
# I'd like to be able print all the known facts about a dinosaur
dino_dex.find_simple(:name, 'Yangchuanosaurus')
