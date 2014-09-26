require_relative 'file_handler'
require_relative 'african_file'
require_relative 'dinosaur'

file_handler = AfricanFile.new('african_dinosaur_export.csv')

all_dinosaurs = file_handler.get_all_dinosaurs

puts all_dinosaurs

#create dinodex object

#import files
#import african_dinosaur_export.csv

#import dinodex.csv

#add dinosaur objects to dinodex

#perform searches against dinodex

#spit out dinosaur info against search results
