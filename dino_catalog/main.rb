require 'csv'
load 'dino_class.rb'
load 'dino_filters.rb'

# This script reads the data and runs the queries of interest
# If you want to run your own queries, you can just call
# the read_data function and store the output in variables
# like the following line of code!
dino_filter_object, dino_objects = read_data

# Find bipeds
puts "**********These are the bipeds!************"
dino_filter_object.find_bipeds.print_list

# Find carnivores
puts "**********These are the carnivores!**********"
dino_filter_object.find_carnivores.print_list

# Find dinos from Cretaceous periods
puts "**********These are the Cretaceous dinos!**********"
dino_filter_object.find_dinos_specific_period('Cretaceous').print_list

# Find big dinos
puts "**********These are the dinos over 2 tons!******"
dino_filter_object.find_big_dinos(4000).print_list

# Find small dinos
puts "**********These are the dinos under 2 tons!*****"
dino_filter_object.find_small_dinos(4000).print_list

# Use multiple filters
puts "**********These are the carnivorous bipeds!*******"
dino_filter_object.find_carnivores.find_bipeds.print_list

# Print one dino
dino_objects[0].print_dino
