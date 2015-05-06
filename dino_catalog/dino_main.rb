require './dino_csv_import.rb'
require './dinodex_class.rb'
dino_input_files = ['./dinodex.csv', './african_dinosaur_export.csv']

my_dinodex = DinoDex.new(CsvImporter.new(dino_input_files).create_dinos)

my_dinodex.run_user_interface
