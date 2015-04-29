require './dino.rb'
# The purpose of this class is to have methods that allow us to filter the
# dinosaur list based on values in its instance variables.

class DinoFilters
  attr_reader :dinos

  def initialize(input_list)
    @dinos = input_list
  end

  def find_bipeds
    filtered_list = @dinos.select(&:biped?)
    DinoFilters.new(filtered_list)
  end

  def find_carnivores
    filtered_list = @dinos.select(&:carnivore?)
    DinoFilters.new(filtered_list)
  end

  def find_dinos_specific_era(era_of_interest)
    filtered_list = @dinos.select { |dino| dino.dino_in_era?(era_of_interest) }
    DinoFilters.new(filtered_list)
  end

  def find_big_dinos(weight_cutoff)
    # weight_cutoff should be in pounds
    filtered_list = @dinos.select { |dino| dino.big_dino?(weight_cutoff) }
    DinoFilters.new(filtered_list)
  end

  def find_small_dinos(weight_cutoff)
    filtered_list = @dinos.select { |dino| dino.small_dino?(weight_cutoff) }
    DinoFilters.new(filtered_list)
  end

  def summarize_list
    summarized_dinos = []
    @dinos.each do |dino|
      summarized_dinos += dino.summarize_dino
    end
    summarized_dinos
  end

  # Want the ability to print single dino's data based on its index in dino list
  def get_dino_by_index(dino_index)
    @dinos[dino_index].summarize_dino
  end
end
