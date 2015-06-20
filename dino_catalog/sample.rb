# Dino Catalog
# Sample Program

require 'csv'
require 'pry'
require 'rails'
require './dinodex'

files = ['african_dinosaur_export.csv', 'dinodex.csv']

dex = DinoDex.new(files)
dinos = dex.dinos
binding.pry
a = 1

