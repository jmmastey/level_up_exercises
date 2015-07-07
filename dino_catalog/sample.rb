# Dino Catalog
# Sample Program

require 'csv'
require 'rails'
require 'pry'
require './dinodex'

files = ['african_dinosaur_export.csv', 'dinodex.csv']

# Generate DinoDex
dex = DinoDex.new_from_files(files)

#Grab an Array of All Dinosaurs in the DinoDex
dinos = dex.dinos

# Generate a new DinoDex with bipeds
bipeds = dex.bipeds
# Generate an Array of All Bipeds in the Biped Dex
bipeds_arr = bipeds.dinos

# Combine Filters
mixed = dex.filter(:big, :cretaceous)

# Print a DinoDex
puts dex.jurassic
