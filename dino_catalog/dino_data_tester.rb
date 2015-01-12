# Run some tests on dino_data
# See https://github.com/jmmastey/level_up_exercises/tree/master/dino_catalog
require 'pry'
require './dino_csv_data_mapper'

# Run it
dino_mapper = DinoCSVDataMapper.new

puts "Dinos that walk biped"
dino_res = dino_mapper.find_by_attr("walking", "biped")
dino_mapper.cout dino_res

puts "Dinos that are carnivores"
dino_res = dino_mapper.find_by_attr("diet", "carnivore")
dino_mapper.cout dino_res

puts "Dinos from Jurassic period"
dino_res = dino_mapper.find_by_attr("period", "jurassic")
dino_mapper.cout dino_res

puts "Big Dinos > 4000 lbs (2 tons)"
dino_res = dino_mapper.find_by_attr_cond("weight", "> 4000")
dino_mapper.cout dino_res

puts "Carnivores from Europe"
dino_res = dino_mapper.find_by_attr("diet", "carnivore")
dino_res = dino_mapper.find_by_attr("continent", "europe", dino_res)
dino_mapper.cout dino_res

puts "Carnivores from Europe (take 2)"
dino_res = dino_mapper.chain_find_by_attr(diet: "carnivore", continent: "europe")
dino_mapper.cout dino_res

puts "Export JSON"
p dino_mapper.jsonOut
