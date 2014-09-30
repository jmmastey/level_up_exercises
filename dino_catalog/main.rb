require_relative "african_mapper"
require_relative "dino_dex_mapper"
require_relative "dino_file_parser"
require_relative "dino_dex"

mappers = DinoDexMapper.get_mapper.merge(AfricanMapper.get_mapper)
parser = DinoFileParser.new(mappers)
dinodex = DinoDex.new(parser.load(["dinodex.csv","african_dinosaur_export.csv"]))

puts "--------------------------"
puts "All Bipeds: "
dinodex.walking("Biped").print

puts ""
puts "All Carnivores"
puts "--------------------------"
dinodex.carnivore.print

puts ""
puts "By Period - Jurassic"
puts "--------------------------"
dinodex.when("Jurassic").print

puts ""
puts "Big Dinosaurs"
puts "--------------------------"
dinodex.big.print

puts ""
puts "Small Dinosaurs"
puts "--------------------------"
dinodex.small.print

puts ""
puts "Big Carnivores from Jurassic times."
puts "--------------------------"
dinodex.big.carnivore.when("Cretaceous").print

puts ""
puts "Dinosarus via search hash"
puts "--------------------------"
parameters = {:walking => "Biped", :period => "Jurassic"}
dinodex.search(parameters).each {|dino| puts dino}

puts ""
puts "To JSON"
puts "--------------------------"
puts dinodex.to_json
