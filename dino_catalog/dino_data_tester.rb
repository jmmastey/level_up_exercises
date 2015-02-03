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
puts "\nDinos from Early/Late Cretaceous period"
puts dino_mapper.find(period: "cretaceous")

puts "\nCarnivores from Europe"
puts dino_mapper.find(diet: "carnivore", continent: "europe")
puts "\nCarnivores from Europe (take 2)"
puts dino_mapper.find(diet: "carnivore").find(continent: "europe")

puts "\nBig Dinos > 4000 lbs (2 tons)"
puts dino_mapper.find_large

puts "\nExport JSON"
p dino_mapper.find.to_json

