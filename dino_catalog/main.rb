#!/usr/bin/env ruby

require_relative 'dinosaur'
require_relative 'dinosaur_parser'
require_relative 'dinosaur_catalog'
require_relative 'dinosaur_opt_parser'

opt_parser = DinosaurOptParser.new
catalog    = DinosaurCatalog.new
options    = opt_parser.parse(ARGV)

if options[:files].nil? || options[:files].empty?
  $stderr.puts "ERROR: You should provide a input file name"
  $stderr.puts ""
  exit
end

options[:files].each do |f|
  dinosaurs = DinosaurParser.parse(f)
  catalog.add(dinosaurs)
end

options.each do |k, v|
  unless (k == :files) || (k == :json)
    catalog.add_filter(k, v)
  end
end

if options.key? :json
  catalog.save_json(options[:json])
else
  catalog.display
end