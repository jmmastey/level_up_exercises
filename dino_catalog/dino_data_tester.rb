# Run some tests on dinodex
# See https://github.com/jmmastey/level_up_exercises/tree/master/dino_catalog
require 'pry'
require './dino_csv_data_mapper'
require './dinosaur_collection'

# Run it
dino_data_mapper = DinoCSVDataMapper.new('dinodex.csv', 'african_dinosaur_export.csv')
dino_collection = DinosaurCollection.new(dino_data_mapper.dinosaurs)

puts "\nDinos that walk biped"
puts dino_collection.find(walking: "biped")
puts "\nDinos that are carnivores"
puts dino_collection.find(diet: "carnivore")

puts "\nDinos from Jurassic period"
puts dino_collection.find(period: "jurassic")
puts "\nDinos from Early/Late Cretaceous period"
puts dino_collection.find(period: "cretaceous")

puts "\nCarnivores from Europe"
puts dino_collection.find(diet: "carnivore", continent: "europe")
puts "\nCarnivores from Europe (take 2)"
puts dino_collection.find(diet: "carnivore").find(continent: "europe")

puts "\nBig Dinos > 4000 lbs (2 tons)"
puts dino_collection.find_large

puts "\nExport JSON"
p dino_collection.find.to_json
