require 'csv'
require_relative './dino.rb'
require_relative './dino_filters.rb'
require_relative './data_reader.rb'

# This script reads the data and runs the queries of interest
# If you want to run your own queries, you can just need
# to get the dino_filter_object

data_reader_object = DataReader.new('dino_csv_list')
dino_filter_object = data_reader_object.read_data

puts "**********These are the bipeds!************"
dino_filter_object.find_bipeds.print_list

puts "**********These are the carnivores!**********"
dino_filter_object.find_carnivores.print_list

puts "**********These are the Cretaceous dinos!**********"
dino_filter_object.find_dinos_specific_period('Cretaceous').print_list

puts "**********These are the dinos over 2 tons!******"
dino_filter_object.find_big_dinos(4000).print_list

puts "**********These are the dinos under 2 tons!*****"
dino_filter_object.find_small_dinos(4000).print_list

puts "**********These are the carnivorous bipeds!*******"
dino_filter_object.find_carnivores.find_bipeds.print_list

dino_filter_object.print_dino_by_index(0)
