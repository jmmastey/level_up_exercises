#!/usr/bin/env ruby
# File dinodex.rb
require 'csv'
require './csv_converters'
class RowPartition
  attr_accessor :header, :fields

  def initialize(header, fields)
    @header = header
    @fields = fields
  end
end

class Dinodex
  attr_reader :catalog, :catalog_hash_array


  def initialize
    @catalog = false
    @catalog_hash_array ||= []
    open_csv
  end

  def open_csv
    csv_tables = []

    Dir.glob('*.csv').each do |file|

      initial_table = CSV.read(file, headers: true,
                             :converters => [:weight_in_lbs, :diet, :all],
                             :header_converters => [:africa, :symbol],
                             :unconverted_fields => true
      )
      if initial_table.has_key?"weight_in_lbs"
      end

    end

    csv_tables.each do |table|
      # sorted_headers = CSV::Row.new(table.by_col!.headers.sort, table.fields)
      entry = table.by_col!.sort.to_a.to_h
      catalog_hash_array << entry


      @catalog ||= entry
      @catalog = entry if entry.keys.count > @catalog.keys.count


    end
    catalog_hash_array.delete(catalog) if catalog_hash_array.include? catalog
    catalog_hash_array.each do |entry|
      entry.each do |dino|
        key = dino.delete(dino.first)
        dino.each { |record|
          record.each { |record_entry|
            catalog[key] << record_entry if catalog.has_key? key }

        }
      end
    end
    puts catalog
  end
end

dex = Dinodex.new