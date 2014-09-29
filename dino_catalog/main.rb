require_relative 'african_file'
require_relative 'dinodex_file'
require_relative 'dinodex'

#Grab all the dinosaurs from the african file
all_african_dinosaurs = AfricanFile.new('african_dinosaur_export.csv').get_all_objects

#Grab all the dinosaurs from the dinodex file
all_dinodex_dinosaurs = DinodexFile.new('dinodex.csv').get_all_objects

dinodex = Dinodex.new(all_african_dinosaurs + all_dinodex_dinosaurs)

#Get all bipeds
#dinodex.dup.filter(:walking, 'Biped').to_s

#Get all carnivores (basically all non-herbivores)
#dinodex.dup.filter(:diet, 'Carnivore').to_s

#Get specific periods (Cretaceous, Permian, Jurassic, Triassic)
#TODO support multiple values
#dinodex.dup.filter(:period, ['Jurassic', 'Triassic'])

#Get all small dinosaurs from North America
dinodex.dup.filter(:weight, 'small').filter(:continent, 'North America').to_s

#JSON examples
#dinodex.dup.filter(:name, "Suchomimus").to_json
#dinodex.dup.filter(:weight, 'small').filter(:continent, 'North America').to_json
