# Our Dinodex is stored as an array. We perform various array ops to query.

require_relative('csv_parser')
require_relative('dinosaur.rb')
require('json')

class Array
  def query_walking(type)
    walkers_of_type = []
    each do |dino|
      walkers_of_type << dino if dino.walking_type?(type)
    end
    walkers_of_type
  end

  def find_all_carnivores
    carnivores = []
    each do |dino|
      carnivores << dino if dino.carnivore?
    end
    carnivores
  end

  def find_all_in_period(period)
    in_period = []
    each do |dino|
      in_period << dino if dino.in_period?(period)
    end
    in_period
  end

  def find_all_above_weight(weight)
    above_weight = []
    each do |dino|
      above_weight << dino if dino.above_weight?(weight)
    end
    above_weight
  end

  def find_all_below_weight(weight)
    below_weight = []
    each do |dino|
      below_weight << dino if dino.below_weight?(weight)
    end
    below_weight
  end
end

dex = DinodexParserCSV.new('dinodex.csv')
list = dex.parse('dinodex.csv')
puts 'All bipeds:'
puts list.query_walking('Biped')
puts 'All Carnivores:'
puts list.find_all_carnivores
puts 'All dinosaurs in cretaceous period:'
puts list.find_all_in_period('cretaceous')
puts 'All large dinosaurs:'
puts list.find_all_above_weight(2000)
puts 'All small Dinosaurs (includes dinosaurs without weight):'
puts list.find_all_below_weight(1000)
puts 'Chaining example'
puts list.query_walking('Biped').find_all_carnivores
