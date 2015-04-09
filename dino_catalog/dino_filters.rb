# This file contains functions that can be used to filter the dinosaurs to find
# ones with specific attributes.

class DinoFilters
  attr_reader :dino_objects

  @dino_objects = nil

  def initialize(input_list)
    @dino_objects = input_list
  end

  def find_bipeds
    filtered_list = @dino_objects.select { |dino| dino.feet[/Biped/] == "Biped" }
    DinoFilters.new(filtered_list)
  end

  def find_carnivores
    filtered_list = @dino_objects.select { |dino| dino.diet == true }
    DinoFilters.new(filtered_list)
  end

  def find_dinos_specific_period(period)
    # ignore case of the text in period with /i in regular expression
    filtered_list = @dino_objects.select { |dino| \
                                     dino.period[/#{period}/i].nil?   }
    DinoFilters.new(filtered_list)
  end

  def find_big_dinos(size)
    # size should be an integer that is the cutoff for the weight
    filtered_list = @dino_objects.select { |dino| dino.weight > size unless dino.weight.nil? }
    DinoFilters.new(filtered_list)
  end

  def find_small_dinos(size)
    filtered_list = @dino_objects.select { |dino| dino.weight < size unless dino.weight.nil? }
    # size should be an integer that is the cutoff for the weight
    DinoFilters.new(filtered_list)
  end

  def print_list
    for dino in @dino_objects
      dino.print_dino
    end
  end
end
