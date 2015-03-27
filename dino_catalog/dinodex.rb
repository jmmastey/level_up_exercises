class Dinodex

require_relative 'dinoConverter'
require 'pp'

@array_of_dinos= []

# Dinodex should do two things. 1: hold data. 2: return selections of that data. 

def initialize(ARGV)
  @array_of_dinos = DinoConverter.csv_files_to_dino_array(ARGV)
end

def check_args(args)
  if args == []
    abort("Please include CSV files as arguments. Exiting...")
  end
end

def filter_by_constraint(field, value, array_of_dinos) # this doesn't work exactly yet

  puts field.chomp "SMALL"

  if field.chomp == "BIG"
    return array_of_dinos.select {|dino| dino.heavier_than?(4000)}
  elsif field.chomp == "SMALL"
    return array_of_dinos.select {|dino| 
      puts "YO IT'S RIGhT HERE" + dino.heavier_than?(4000)
      dino.heavier_than?(4000)}
  elsif !value.nil?
    return array_of_dinos.select {|dino| dino.like?(field, value) }
  else
    puts "This query doesn't make sense. Get out of here."
  end
  return array_of_dinos
end

def self.run_via_console

  dinodex = Dinodex.new(ARGV)
  dinodex.check_args
  array_of_dinos = DinoConverter.csv_files_to_dino_array(ARGV)
  pp array_of_dinos # it's really not that pretty, ruby.
  p "Here's the entire set."
  dinodex.filter_loop(array_of_dinos)

end

end 

