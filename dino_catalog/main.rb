#!/usr/bin/ruby

require 'csv'
require 'json'
require_relative 'dinodex_mapper'
require_relative 'africandino_mapper'
require_relative 'dinodex.rb'
require_relative 'dinosaur.rb'

dino = DinoDex.new()

file_paths = ['dinodex.csv', 'african_dinosaur_export.csv']

puts "**************************************************\n"
puts "Voila! Both files merged:"
puts "**************************************************\n"
puts merge_dino = dino.merge_parser(file_paths)

puts "\nBIPEDS:\n"
puts "**************************************************\n"
puts dino.filter(:walking,"Biped")

puts "\nCARNIVORES:\n"
puts "**************************************************\n"
merge_dino.each do |dinos| 
  puts dinos unless dinos.diet == 'Herbivore'
end

puts "\nCRETACEOUS PERIOD:\n"
puts "**************************************************\n"
puts dino.filter(:period,"Cretaceous")

puts "\nHeavy Dinos (> 2tons):"
puts "**************************************************\n"
heavy = merge_dino.each do |dinos| 
  puts dinos if dinos.weight.to_i > 4000
end

puts "\nLight Dinos (<= 2tons):"
puts "**************************************************\n"
light = merge_dino.each do |dinos| 
    puts dinos if dinos.weight.to_i <= 4000
end

puts "\nChaining Criteria:"
puts "Biped dinos and dinos from Jurassic period:" 
puts "**************************************************\n"
puts dino.filter(:walking,"Biped").filter(:period,"Jurassic")

puts "\nCombined filter:"
puts "Biped dinos from Jurassic period only:"
puts "**************************************************\n"
puts dino.combined(walking: "Biped",period: "Jurassic")

puts "\nAs a JSON:"
puts "**************************************************\n"
puts merge_dino.to_json
