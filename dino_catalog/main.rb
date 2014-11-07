#!/usr/bin/env ruby

require_relative 'dinosaur'
require_relative 'dinosaur_parser'
require_relative 'dinosaur_catalog'
require_relative 'dinosaur_opt_parser'

opt_parser = DinosaurOptParser.new
catalog    = DinosaurCatalog.new

begin
  options    = opt_parser.parse(ARGV)
rescue OptionParser::ParseError
  abort "ERROR: Failed to parse provided options"
end

abort "ERROR: No input file was provided" unless options[:files]

options[:files].each do |f|
  dinosaurs = DinosaurParser.new(f).parse
  catalog.add(dinosaurs)
end

options.each do |k, v|
  next if (k == :files) || (k == :json)

  if v == true
    catalog.add_filter(k)
  else
    catalog.add_filter(k, v)
  end
end

if options.key? :json
  catalog.save_json(options[:json])
else
  catalog.to_s
end
