require './dino_csv_import.rb'
require './dinodex_class.rb'


dino_input_files = ['./dinodex.csv', './african_dinosaur_export.csv']

csv_array = CsvImporter.new(dino_input_files).create_dinos

 # puts csv_array[9].name

my_dinodex = DinoDex.new(csv_array)
my_dinodex.get_matching_dinos('Biped')

puts "What kind of dino would you like to view?"
filter = gets.chomp
my_dinodex.get_matching_dinos(filter)

