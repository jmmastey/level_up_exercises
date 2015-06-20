# Dino Catalog
# Sample Program

require 'csv'
require 'pry'
require 'rails'
require './dinoparse'

files = ['african_dinosaur_export.csv', 'dinodex.csv']

dinos = DinoParse.new(files)
binding.pry
a = 1

