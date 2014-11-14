require 'table_print'
require 'csv'
require 'json'
require_relative 'dinosaurs.rb'
require_relative 'dinosaur_catalog.rb'

dino_dex = DinoDex.new

def user_answer
  puts 'Enter y for data,n for go to next question and q for quite'
  answer = gets.chomp
  abort if answer == 'q'
  answer
end

puts "=================================================\n"
puts "Here is the Dinosaur Catalog File"
puts "==================================================\n"

dino_dex.parser_file('dinodex.csv')
tp merge_dino = dino_dex.parser_file('african_dinosaur_export.csv')

puts "=================================================\n"
puts "Its Fun time lets get some answers \n"
puts "=================================================\n"

puts "Garb the dinosaurs that were bipeds."
tp dino_dex.bipeds if user_answer == 'y'

puts "=================================================\n"

puts "Garb all the dinosaurs that were carnivores."
tp dino_dex.carnivores if user_answer == 'y'

puts "=================================================\n"

puts "Data for any other specific periods."

while user_answer == 'y'
  puts "Garb all the dinosaurs that were specific periods?"
  puts "i.e (Jurassic | Triassic | Albian )."
  period = user_answer.downcase
  tp dino_dex.periods(period)
end

puts "=================================================\n"

puts "Grab dinosaurs > 2 tons"
tp dino_dex.big if user_answer == 'y'

puts "=================================================\n"

puts "Grab dinosaurs < 2 tons"
tp dino_dex.small if user_answer == 'y'

puts "=================================================\n"

puts "question is over.Want to go back to our Dinosaur catalog"
tp merge_dino if user_answer == 'y'

puts "=================================================\n"

puts "Last but not least - output as a JSON."
puts dino_dex.to_json if user_answer == 'y'
