require 'csv'
require_relative './dino.rb'
require_relative './dino_filters.rb'
require_relative './data_reader.rb'

# This script reads the data and runs the queries of interest
# If you want to run your own queries, you can just need
# to get the dino_filter_object

data_reader = DataReader.new('dino_csv_list')
dino_filter = data_reader.dino_filter

puts "**********These are the bipeds!************"
dino_filter.find_bipeds.print_list

puts "**********These are the carnivores!**********"
dino_filter.find_carnivores.print_list

puts "**********These are the Cretaceous dinos!**********"
dino_filter.find_dinos_specific_era('Cretaceous').print_list

puts "**********These are the dinos over 2 tons!******"
dino_filter.find_big_dinos(4000).print_list

puts "**********These are the dinos under 2 tons!*****"
dino_filter.find_small_dinos(4000).print_list

puts "**********These are the carnivorous bipeds!*******"
dino_filter.find_carnivores.find_bipeds.print_list

dino_filter.print_dino_by_index(0)
