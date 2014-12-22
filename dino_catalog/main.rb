
require_relative 'dino_csv_tools'
include DinoCSVTools
require_relative 'dino_dex'
require_relative 'command_line'
require_relative 'dinosaur'

joes_dinos = JoesDinos.new("dinodex.csv")
piratebay_dinos = PirateBayDinos.new("african_dinosaur_export.csv")

command_line = DinoDexCommandLine.new(DinoDex.new(joes_dinos.dinos, piratebay_dinos.dinos))

while true do
  command_line.get_input
end
