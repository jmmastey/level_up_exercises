require_relative 'file_handler'
require_relative 'african_file'
require_relative 'dinodex_file'
require_relative 'dinosaur'

file_handler = AfricanFile.new('african_dinosaur_export.csv')
all_african_dinosaurs = file_handler.get_all_dinosaurs

file_handler = DinodexFile.new('dinodex.csv')
all_dinodex_dinosaurs = file_handler.get_all_dinosaurs

puts all_african_dinosaurs + all_dinodex_dinosaurs

#create dinodex object

#import files
#import african_dinosaur_export.csv

#import dinodex.csv

#add dinosaur objects to dinodex

#perform searches against dinodex

#spit out dinosaur info against search results
