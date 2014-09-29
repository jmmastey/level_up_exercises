require_relative 'african_file'
require_relative 'dinodex_file'
require_relative 'dinodex'

#Grab all the dinosaurs from the african file
all_african_dinosaurs = AfricanFile.new('african_dinosaur_export.csv').get_all_objects

#Grab all the dinosaurs from the dinodex file
all_dinodex_dinosaurs = DinodexFile.new('dinodex.csv').get_all_objects

dinodex = Dinodex.new(all_african_dinosaurs + all_dinodex_dinosaurs)

#puts dinodex.filter(:walking, 'Biped').to_s
puts dinodex.to_s

#spit out dinosaur info against search results
