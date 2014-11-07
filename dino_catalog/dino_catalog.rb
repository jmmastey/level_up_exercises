#!/usr/bin/ruby -w

this_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(this_dir + "/lib") unless $LOAD_PATH.include?(this_dir)

require "dinosaur_index"
#require "dinosaur_index/csv_loader"
require "dinosaur_index/cli"
require "json"

cli_parser = DinosaurIndex::CommandLineInterface.new
cli_parser.parse!(ARGV)
puts cli_parser.dinosaur_filters.inspect

exit 0
cli_parser.input_files.each do |inputfile|
  csvloader = DinosaurIndex::CSVLoader.new(inputfile.pathname,
                                           inputfile.dino_attribute_defaults)
  csvloader.read { |dinosaur| dino_list << dinosaur }
end

if cli_parser.output_json
  puts dino_list.map(&:to_hash).to_json(
    indent: ' ', space: ' ', object_nl: "\n", array_nl: "\n")
else
  dino_list.each do |dinosaur|
    puts "--- #{dinosaur} ---"
    puts dinosaur.full_description, "\n"
  end
end
