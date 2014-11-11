require 'table_print'
require 'csv'
require 'json'
require_relative 'Dinosaur_catalog.rb'

dino = DinoDex.new

file_paths = ['dinodex.csv', 'african_dinosaur_export.csv']

puts "=================================================\n"
puts "Here is the Dinosaur Catalog File"
puts "==================================================\n"
tp merge_dino = dino.parser_file(file_paths)

puts "=================================================\n"
puts "Its Fun time lets get some answers \n"
puts "=================================================\n"

puts "Garb the dinosaurs that were bipeds?Enter y or n"
user_answer = gets.chomp
tp dino.bipeds if user_answer == 'y'

puts "=================================================\n"

puts "Garb all the dinosaurs that were carnivores?y or n"
user_answer = gets.chomp
tp dino.carnivores if user_answer == 'y'

puts "=================================================\n"

puts "Garb all the dinosaurs that were specific periods?"
puts "Like enter Jurassic,Triassic,Albian, etc"
user_answer = gets.chomp.downcase
tp dino.periods(user_answer)

puts "Data for any other specific periods?Enter y or n"
user_answer = gets.chomp

if user_answer == 'y'
  puts "Garb all the dinosaurs that were specific periods."
  user_answer = gets.chomp.downcase
  tp dino.periods(user_answer)
end

puts "=================================================\n"

puts "Grab dinosaurs > 2 tons ?Enter y or n"
user_answer = gets.chomp
tp dino.big if user_answer == 'y'

puts "=================================================\n"

puts "Grab dinosaurs < 2 tons ?Enter y or n"
user_answer = gets.chomp
tp dino.small if user_answer == 'y'

puts "=================================================\n"

puts "question is over.Want to go back to our Dinosaur catalog?Enter y or n"
user_answer = gets.chomp
tp merge_dino if user_answer == 'y'

puts "=================================================\n"

puts "Last but not least - output as a JSON.Enter y or n"
user_answer = gets.chomp
puts dino.to_json if user_answer == 'y'
