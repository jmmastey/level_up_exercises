require_relative "african_file"
require_relative "dinodex_file"
require_relative "dinodex"

# Grab all the dinosaurs from the african file
all_african_dinosaurs = AfricanFile.new("african_dinosaur_export.csv")
                                   .all_objects

# Grab all the dinosaurs from the dinodex file
all_dinodex_dinosaurs = DinodexFile.new("dinodex.csv").all_objects

dinodex = Dinodex.new(all_african_dinosaurs + all_dinodex_dinosaurs)

# Get all bipeds
puts dinodex.filter(:walking, "Biped").to_s

# Get all carnivores (basically all non-herbivores)
puts dinodex.filter(:diet, "Carnivore").to_s

# Get specific time periods
puts dinodex.filter(:period, "Jurassic").to_s
puts dinodex.filter(:period, "Triassic").to_s
puts dinodex.filter(:period, "Cretaceous").to_s

# Get all big dinosaurs (over 2 tons)
puts dinodex.filter("big_as_string", "yes").to_s

# Get all small dinosaurs from North America
puts dinodex.filter("big_as_string", "no")
            .filter(:continent, "North America")
            .to_s

# Get all herbivores, that are quadruped, that live in Africa
puts dinodex.filter(:diet, "Herbivore")
            .filter(:walking, "Quadruped")
            .filter(:continent, "Africa")
            .to_s

# JSON examples
puts dinodex.filter(:name, "Suchomimus").to_json
puts dinodex.filter(:diet, "Herbivore").to_json
puts dinodex.filter("big_as_string", "no")
            .filter(:continent, "North America")
            .to_json
