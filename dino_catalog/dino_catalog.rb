#!/usr/bin/ruby -w

this_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(this_dir + "/lib") unless $LOAD_PATH.include?(this_dir)

require "dinosaur_index"
require "dinosaur_index/csv_loader"
require "dinosaur_index/cli"
require "json"

include DinosaurIndex

catalog = Catalog.new
cli_parser = CommandLineInterface.new(catalog)
cli_parser.parse!(ARGV)

cli_parser.input_files.each do |file|
  csvloader = CSVLoader.new(file.pathname, file.dino_attribute_defaults)
  csvloader.read { |dinosaur| catalog << dinosaur }
end

if cli_parser.output_json
  puts dino_list.map(&:to_hash).to_json(
    indent: ' ', space: ' ', object_nl: "\n", array_nl: "\n")
else
  catalog.each do |dinosaur|
    puts "--- #{dinosaur} ---"
    puts dinosaur.full_description, "\n"
  end
end
