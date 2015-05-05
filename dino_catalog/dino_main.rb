require './dino_csv_import.rb'
require './dinodex_class.rb'


dino_input_files = ['./dinodex.csv', './african_dinosaur_export.csv']

#csv_array = CsvImporter.new(dino_input_files).create_dinos
# puts csv_array[9].name

my_dinodex = DinoDex.new(CsvImporter.new(dino_input_files).create_dinos)
#p my_dinodex.filter_dinos('Biped')

my_dinodex.run_user_interface
