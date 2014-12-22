
require_relative 'dino_csv_tools'
include DinoCSVTools
require_relative 'dino_dex'
require_relative 'command_line'
#include DinoDexCommandLine
require_relative 'dinosaur'

joes_dinos = DinoCSVTools::CSV_to_hash_array("dinodex.csv")
piratebay_dinos = DinoCSVTools::normalize_african_dinos(DinoCSVTools::CSV_to_hash_array("african_dinosaur_export.csv"))
merged_dinos = joes_dinos.concat(piratebay_dinos)

dino_names = merged_dinos.map{ |dino_hash| dino_hash[:name].to_s.downcase }

#$dino_dex = DinoDex.new(merged_dinos)

command_line = DinoDexCommandLine.new(DinoDex.new(merged_dinos), dino_names)

while true do
  command_line.get_input
end