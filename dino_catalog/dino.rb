require './dino_csv_import.rb'
require './dinoclass.rb'



dino_input_files = ['./dinodex.csv', './african_dinosaur_export.csv']
csv_array = Array.new
dino_input_files.each { |fname| csv_array += CsvImporter.new.import(fname) }

  #p csv_array
  #puts csv_array[9][:name]

my_dinodex = DinoDex.new(csv_array)
#puts my_dinodex.find('biped')

