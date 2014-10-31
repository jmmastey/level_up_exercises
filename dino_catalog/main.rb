#!/usr/bin/env ruby

require_relative 'dinosaur'
require_relative 'dinosaur_parser'
require_relative 'dinosaur_catalog'
require_relative 'dinosaur_opt_parser'

opt_parser = DinosaurOptParser.new
catalog    = DinosaurCatalog.new
options    = opt_parser.parse(ARGV)

options[:files].each do |f|
  dinosaurs = DinosaurParser.new(f).parse
  catalog.add(dinosaurs)
end

options.each do |k, v|
  catalog.add_filter(k, v) unless (k == :files) || (k == :json)
end

if options.key? :json
  catalog.save_json(options[:json])
else
  catalog.display
end
