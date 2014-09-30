#!/usr/bin/ruby

require 'csv'
require 'json'
require_relative 'dinoparser.rb'
require_relative 'dino.rb'
require_relative 'dinosaur.rb'

dino = Dino.new()

file_paths = ['dinodex.csv', 'african_dinosaur_export.csv']

puts "**************************************************\n"
puts "Voila! Both files merged:\n"
puts "**************************************************\n"
puts merge_dino = dino.merge(file_paths)

puts "\nBIPEDS:\n"
puts "**************************************************\n"
puts bipeds = dino.filter(:walking,"Biped")

puts "\nCARNIVORES:\n"
puts "**************************************************\n"
merge_dino.each do |dinos| 
  puts dinos unless dinos.diet == 'Herbivore'
end

puts "\nCRETACEOUS PERIOD:\n"
puts "**************************************************\n"
puts cretaceous = dino.search_filter(:period,"Cretaceous")

puts "\nPERMIAN PERIOD:\n"
puts "**************************************************\n"
puts permian = dino.search_filter(:period,"Permian")

puts "\nJURASSIC PERIOD:\n"
puts "**************************************************\n"
puts jurassic = dino.search_filter(:period,"Jurassic")

puts "\nOXFORDIAN PERIOD:\n"
puts "**************************************************\n"
puts oxfordian = dino.search_filter(:period,"Oxfordian")

puts "\nALBIAN PERIOD:\n"
puts "**************************************************\n"
puts albian = dino.search_filter(:period,"Albian")

puts "\nTRIASSIC PERIOD:\n"
puts "**************************************************\n"
puts triassic = dino.search_filter(:period,"Triassic")

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
puts chained = bipeds.concat(jurassic)

puts "\nCombined filter:"
puts "Biped dinos from Jurassic period only:"
puts "**************************************************\n"
puts combined = dino.combined(:walking,"Biped",:period,"Jurassic")

puts "\nAs a JSON:"
puts "**************************************************\n"
puts JSON.generate(merge_dino)
