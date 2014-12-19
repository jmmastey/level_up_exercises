
require_relative 'csv_to_hash_tools'
include CSVtoHashTools
require_relative 'dino_dex'
require_relative 'cl'
include DinoDexCommandLine
require_relative 'dinosaur'

joes_dinos = CSVtoHashTools::CSV_to_hash_array("dinodex.csv")
piratebay_dinos = CSVtoHashTools::normalize_african_hash_array(CSVtoHashTools::CSV_to_hash_array("african_dinosaur_export.csv"))
merged_dinos = joes_dinos.concat(piratebay_dinos)

$dino_names = merged_dinos.map{ |dino_hash| dino_hash[:name].to_s.downcase }

$dino_dex = DinoDex.new(merged_dinos)

puts "Welcome to the DinoDex!\n\n"
puts "Available comands:  all_dinos, exit, help, filter [filter1] [filter2] ..., [dinosaur_name]"

#DinoDexCommandLine::get_and_check_input
while true do
  DinoDexCommandLine::get_input
end

DinoDexCommandLine::exit_program