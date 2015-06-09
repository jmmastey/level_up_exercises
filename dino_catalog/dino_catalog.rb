require 'csv'
require 'pry'
require './dino_parse'
require './dinodex'

dinos = CSVParser.read('dinodex.csv', 'african_dinosaur_export.csv')

dinos = dinos.map do |dino|
  Dinosaur.new(dino)
end

dinodex = Dinodex.new(dinos)
original_dinodex = dinodex

puts "Please enter desired properties (Biped, Carnivore, Big or Small, Period) : "
property_string = gets.chomp
properties = property_string.split(",").map(&:strip).map(&:downcase)

properties.each do |property|
  method = "#{property}".to_sym

  dinodex = dinodex.send(method) if dinodex.methods.include?(method)
end

puts dinodex.dino_array.map(&:name)
puts "\n"

puts "Please enter a dinosaur you'd like to learn more about:"
user_dino = gets.chomp
puts "\n"
original_dinodex.dino_all_facts(user_dino.downcase)
