require_relative './dino.rb'
# The purpose of this class is to have methods that allow us to filter the
# dinosaur list based on values in its instance variables.

class DinoFilters
  attr_reader :dino_objects

  @dino_objects = nil

  def initialize(input_list)
    @dino_objects = input_list
  end

  def find_bipeds
    filtered_list = @dino_objects.select { |dino| dino.biped? }
    DinoFilters.new(filtered_list)
  end

  def find_carnivores
    filtered_list = @dino_objects.select { |dino| dino.carnivore? }
    DinoFilters.new(filtered_list)
  end

  def find_dinos_specific_era(era_of_interest)
    filtered_list = @dino_objects.select { |dino| dino.dino_in_era?(era_of_interest) }
    DinoFilters.new(filtered_list)
  end

  def find_big_dinos(weight_cutoff)
    # weight_cutoff should be in pounds
    filtered_list = @dino_objects.select { |dino| dino.big_dino?(weight_cutoff) }
    DinoFilters.new(filtered_list)
  end

  def find_small_dinos(weight_cutoff)
    filtered_list = @dino_objects.select { |dino| dino.small_dino?(weight_cutoff) }
    DinoFilters.new(filtered_list)
  end

  def print_list
    for dino in @dino_objects
      dino.print_dino
    end
  end

  # Want the ability to print single dino's data based on its index in dino list
  def print_dino_by_index(dino_index)
    @dino_objects[dino_index].print_dino
  end
end
