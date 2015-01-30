# Run some tests on dinodex
# See https://github.com/jmmastey/level_up_exercises/tree/master/dino_catalog
require 'pry'
require './dino_csv_data_mapper'

# Run it
dino_mapper = DinoCSVDataMapper.new

puts "\nDinos that walk biped"
puts dino_mapper.find(walking: "biped")

puts "\nDinos that are carnivores"
puts dino_mapper.find(diet: "carnivore")

puts "\nDinos from Jurassic period"
puts dino_mapper.find(period: "jurassic")

puts "Carnivores from Europe"
puts dino_mapper.find(diet: "carnivore").find(continent: "europe")

puts "Export JSON"
p dino_mapper.find.to_json

=begin
#TODO: Do without eval
puts "Big Dinos > 4000 lbs (2 tons)"
#dino_res = dino_mapper.find_by_cond("weight", "> 4000")
#dino_mapper.cout dino_res
=end
