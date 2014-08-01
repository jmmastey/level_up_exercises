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
  attr_accessor :catalog, :catalog_hash_array


  def initialize
    csv_tables = []
    csv_hahses_array = []
    Dir.glob('*.csv').each do |file|

      csv_tables << CSV.read(file, headers: true,
                             :converters => [:all, :weight_in_lbs],
                             :header_converters => [:africa, :symbol]
      )
    end
    csv_tables.each do |table|
      # sorted_headers = CSV::Row.new(table.by_col!.headers.sort, table.fields)
      entry = table.by_col!.sort.to_a.to_h
      @csv_hahses_array << entry
      # rows_array = []
      # # temp_sorted_table.each{ |row|
      # #   # header = [row.slice(row.find_index(row.first))]
      # #   row_info = row.partition{|obj|
      # #     obj.is_a?Symbol}
      # #   part = RowPartition.new(row_info[0].to_s, row_info[1].to_s)
      # #   rows_array << CSV::Row.new(part.header, part.fields)
      # # }
      # entry = CSV::Table.new(rows_array)

      @catalog ||= entry
      catalog = entry if entry.keys.count > catalog.keys.count


    end
    csv_hahses_array.delete(catalog) if csv_hahses_array.include?catalog
    csv_hahses_array.each do |entry|
      entry.each do |dino|
        catalog << dino
      end
    end
    puts catalog
  end
end

dex = Dinodex.new