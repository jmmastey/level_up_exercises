require_relative 'csvtohashtools'
include CSVtoHashTools
require_relative 'dinodex'
require_relative 'dinodexcommandline'
include DinoDexCommandLine
require_relative 'dinosaur'

joes_dinos = CSVtoHashTools::CSV_to_hash("dinodex.csv")
piratebay_dinos = CSVtoHashTools::normalize_african_hash(CSVtoHashTools::CSV_to_hash("african_dinosaur_export.csv"))
merged_dinos = joes_dinos.concat(piratebay_dinos)

$dino_names_array = merged_dinos.map{ |dino_hash| dino_hash[:name].downcase }

$dino_dex = DinoDex.new(merged_dinos)

puts "Welcome to the DinoDex!"
puts "Available comands:  all_dinos, exit, help, filter [filter1] [filter2] ..., [dinosaur_name]
Please enter \"help\" for detailed command documentation."

DinoDexCommandLine::get_and_check_input
