require_relative "dinodex"

dinos = DinoLoader.load("dinodex.csv") +
        DinoLoader.load("african_dinosaur_export.csv")

dinodex = DinoDex.new(dinos)
dinodex.filter_by_walking! "Biped"
puts "Bipeds"
dinodex.display_all

dinodex = DinoDex.new(dinos)
dinodex.filter_carnivores!
puts "Carnivores"
dinodex.display_all

dinodex = DinoDex.new(dinos)
dinodex.filter_by_period! "Cretaceous"
puts "Cretaceous Period"
dinodex.display_all

dinodex = DinoDex.new(dinos)
dinodex.filter_big!
puts "Big"
dinodex.display_all

dinodex = DinoDex.new(dinos)
dinodex.filter_small!
puts "Small"
dinodex.display_all

dinodex = DinoDex.new(dinos)
dinodex.filter_by_walking!("Biped").filter_carnivores!.filter_small!
puts "Small Bipedal Carnivores"
dinodex.display_all
