require 'csv'
require 'json'
require 'colorize'
require 'set'

require './details'
require './alert'
require './dinosaur_catalog'
require './dinosaur_csv_parser'
require './dinodex_controller'


# Usage
if ARGV.empty?
  $stderr.puts "Needs DataFile [DataFile ...] (-d Details)"
  exit
end

# Details
Details.turn_on if ARGV.include? "-d"

# Dino-Files
dino_files = ARGV.select { |arg| arg != "-d" }

# Dinosaur Catalog
catalog = DinosaurCatalog.new

# Parse Files Into Catalog
dino_files.each do |dino_file|
  dinosaurs = DinosaurCSVParser.parse(dino_file)
  catalog << dinosaurs
end

# Start Controller
controller = DinodexController.new(catalog)
controller.run
