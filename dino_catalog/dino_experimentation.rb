require_relative 'dinosaur_catalog'

catalog = DinosaurCatalog.new("dino_catalog/dinodex.csv")

puts "Carnivore, Weight 4001"
catalog.filter_by_diet("Carnivore").filter_by_weight(4001).print

puts "Name: Albertosaurus"
catalog.filter_by_name("Albertosaurus").print

puts "Walking: Biped"
catalog.filter_by_walking("Biped").print

puts "Period: Cretaceous"
catalog.filter_by_period("Cretaceous").print

puts "Continent: North America"
catalog.filter_by_continent("North America").print

puts "Diet: Insectivore"
catalog.filter_by_diet("Insectivore").print

puts "No matches"
catalog.filter_by_period("Nothing").print

puts "All dinosuars"
catalog.all_dinosaurs.print

puts "All dinosaurs with facts"
catalog.all_dinosaurs.print_with_facts
