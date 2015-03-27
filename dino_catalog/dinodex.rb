class Dinodex

require_relative 'dinoConverter'
require 'pp'

attr_reader @array_of_dinos

@array_of_dinos = []
@big = 4000

# Dinodex should do two things. 1: hold data. 2: return selections of that data. 

def initialize(files)
  @array_of_dinos = DinoConverter.csv_files_to_dino_array(files)
end

def filter_by_string(field, value)
  @array_of_dinos.select {|dino| dino.like?(field, value)}
end

def filter_by_string_external_dinos(field, value, dinos) # b/c ruby doesn't support overloading methods
  dinos.select {|dino| dino.like?(field, value)}
end

def filter_by_strings(fields, values)
  i = 0
  filtered_array = @array_of_dinos
  fields.count.times {
    filtered_array = filter_by_string_external_dinos(fields[i], values[i], filtered_array)
    i += 1
  }
  return filtered_array
end

def get_big_dinos
  @array_of_dinos.select {|dino| dino.heavier_than?(@big)}
end

def get_small_dinos
  @array_of_dinos.select {|dino| !dino.heavier_than?(@big)}
end

end 

