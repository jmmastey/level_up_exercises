# Our Dinodex is stored as an array. We perform various array ops to query.

require_relative('csv_parser')
require_relative('dinosaur.rb')

class DinoDex
  def initialize(dino_collection)
    @dinosaurs = dino_collection
  end

  def print
    puts @dinosaurs
  end

  def at_index(index)
    @dinosaurs[index]
  end

  def walking(type)
    new_collection = @dinosaurs.select { |dino| dino.walking_type?(type) }
    DinoDex.new(new_collection)
  end

  def carnivores
    new_collection = @dinosaurs.select(&:carnivore?)
    DinoDex.new(new_collection)
  end

  def in_period(period)
    new_collection = @dinosaurs.select { |dino| dino.in_period?(period) }
    DinoDex.new(new_collection)
  end

  def above_weight(weight)
    new_collection = @dinosaurs.select { |dino| dino.above_weight?(weight) }
    DinoDex.new(new_collection)
  end

  def below_weight(weight)
    new_collection = @dinosaurs.select { |dino| dino.below_weight?(weight) }
    DinoDex.new(new_collection)
  end
end
