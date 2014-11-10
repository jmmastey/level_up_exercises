require 'table_print'
require 'csv'
require 'json'
require_relative 'Dinosaur_catalog.rb'

dino = DinoDex.new()

file_paths = ['dinodex.csv', 'african_dinosaur_export.csv']


puts "=================================================\n"
puts   "Here is the Dinosaur Catalog File"
puts "==================================================\n"
tp merge_dino = dino.parser_file(file_paths)

puts "=================================================\n"
puts "Its Fun time lets get some answers \n"
puts "=================================================\n"

puts "Do you want to garb the dinosaurs that were bipeds? If yes enter y or n"
user_answer = gets.chomp
tp dino.bipeds if user_answer == 'y'

puts "=================================================\n"

puts "Do you want to garb all the dinosaurs that were carnivores? If yes enter y or n "
user_answer = gets.chomp
tp  dino.carnivores if user_answer == 'y'

puts "=================================================\n"

puts "Do you want to garb all the dinosaurs that were specific periods?Like enter Jurassic,Triassic,Albian, etc"
user_answer=gets.chomp.downcase
tp  dino.periods(user_answer)

puts "Do you want to see data for  any other specific periods? If yes enter y or n"
user_answer=gets.chomp

  if user_answer == 'y'
  puts "Do you want to garb all the dinosaurs that were specific periods.Like enter jurassic,triassic,albian, etc"
  user_answer=gets.chomp.downcase
  tp  dino.periods(user_answer)
  end

puts "=================================================\n"

puts "Do you want to grab dinosaurs > 2 tons ? If yes enter y or n"
user_answer = gets.chomp
tp period_dino = dino.big if user_answer == 'y'

puts "=================================================\n"

puts   "Grab dinosaurs < 2 tons ? If yes enter y or n"
user_answer = gets.chomp
tp period_dino = dino.small if user_answer == 'y'

puts "=================================================\n"

puts   "question is over so do you want to go  back to our Dinosaur catalog? If yes enter y or n"
user_answer = gets.chomp
tp merge_dino if user_answer == 'y'

puts "=================================================\n"

puts "Last but not least - output as a JSON.If yes enter y or n"
user_answer = gets.chomp
puts json_conv= dino.to_json if user_answer == 'y'


