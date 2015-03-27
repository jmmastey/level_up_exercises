class Dinodex

require_relative 'dinoConverter'
require 'pp'

def initialize(files)
  @array_of_dinos = DinoConverter.csv_files_to_dino_array(files)
  @big = 4000
end

def array_of_dinos
  return @array_of_dinos
end

def filter_by_string(field, value)
  @array_of_dinos.select {|dino| dino.like?(field, value)}
end

def filter_by_strings(constraints)
  filtered_array = @array_of_dinos
  constraints.each do |constraint| 
    filtered_array = filter_selection_by_string(constraint[0], constraint[1], filtered_array)
  end
  return filtered_array
end

def get_big_dinos
  @array_of_dinos.select {|dino| dino.heavier_than?(@big)}
end

def get_small_dinos # didn't use !heavier_than b/c then entries with nil weight would have returned true.
  @array_of_dinos.select {|dino| dino.lighter_than?(@big)}
end

private
def filter_selection_by_string(field, value, dinos)
  dinos.select {|dino| dino.like?(field, value)}
end

end 

