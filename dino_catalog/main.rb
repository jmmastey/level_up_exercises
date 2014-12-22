
require_relative 'dino_csv_tools'
include DinoCSVTools
require_relative 'dino_dex'
require_relative 'command_line'
require_relative 'dinosaur'

command_line = DinoDexCommandLine.new("dinodex.csv", "african_dinosaur_export.csv")
