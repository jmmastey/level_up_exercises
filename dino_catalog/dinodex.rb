class Dinodex

  require_relative 'dinoConverter'
  require 'pp'

  BIG = 4000

  def initialize(files)
    @array_of_dinos = DinoConverter.csv_files_to_dino_array(files)
  end

  def array_of_dinos
    @array_of_dinos
  end

  def filter_by_string(field, value)
    @array_of_dinos.select {|dino| dino.like?(field, value)}
  end

  def filter_by_strings(constraints)
    filtered_array = @array_of_dinos
    constraints.each do |constraint| 
      filtered_array = filter_selection_by_string(constraint[0], 
        constraint[1], filtered_array)
    end
    filtered_array
  end

  def big_dinos
    @array_of_dinos.select {|dino| dino.heavier_than?(BIG)}
  end

  def small_dinos
    @array_of_dinos.select {|dino| dino.lighter_than?(BIG)}
  end

  def carnivores
    carnivores = @array_of_dinos.select { |dino| 
    	dino.like?("DIET", "Carnivore") || 
    	dino.like?("DIET", "Piscivore") || 
    	dino.like?("DIET", "Insectivore")
    }
  end

  private
  def filter_selection_by_string(field, value, dinos)
    dinos.select {|dino| dino.like?(field, value)}
  end

end 

