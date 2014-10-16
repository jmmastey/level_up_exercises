#!/usr/bin/ruby -w

this_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(this_dir) unless $LOAD_PATH.include?(this_dir)

require "queriable_array"
require "dinodex"
require "dinodex/csv_loader"
require "dinodex_cli"
#require "pry"

cli_parser = Dinodex::CommandLineInterface.new
cli_parser.parse!(ARGV)
dino_list = cli_parser.filtering_list

cli_parser.input_files.each do |filename, field_defaults|
  Dinodex::CSVLoader.new(filename, field_defaults).read do |dinosaur|
    dino_list << dinosaur
  end
end

dino_list.each do |dinosaur|
  puts "--- #{dinosaur} ---"
  puts dinosaur.full_description, "\n"
end
