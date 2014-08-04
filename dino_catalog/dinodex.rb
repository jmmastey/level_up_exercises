#!/usr/bin/env ruby
# File dinodex.rb
require 'csv'
require 'hirb'
require './csv_converters'
require './dinosaur'

class Dinodex
  attr_accessor :catalog, :catalog_hash_array


  def initialize(config = {})
    self.catalog = {}
    self.catalog_hash_array ||= []
    options = {
    :path => config[:path] || '*.csv',
    :headers => config[:include_headers] || true,
    :header_converters => config[:header_converters] || [],
    :converters => config[:converters] || []
    }

    open_csv(options)
  end

  private
  def open_csv(options ={})
    csv_tables = []
    file_path = options.delete(:path)

    Dir.glob(file_path).each do |file|

      initial_table = CSV.read(file, options)
      csv_tables << initial_table

    end

    process_csv(csv_tables)
  end

  def process_csv(csv_tables)
    csv_tables.each do |table|
        table.by_row.each { |dino|
          tmp_dino = Dinosaur.new
          ops = {}
          table.headers.each do |header|
            ops[header] = dino[header]
          end
          self.catalog[ops[:name]] = Dinosaur.new(ops)}
    end
  end

  public
  def show_data()
    if self.catalog
      display_array = []
      headers = ["Name", "Period", "Continent", "Diet", "Weight", "Walking", "Description"]
      self.catalog.values.each { |entry|
        display_array << [entry.name, entry.period,
                                                    entry.continent, entry.diet,
                                                    entry.weight, entry.walking, entry.description] }
      puts Hirb::Helpers::AutoTable.render(display_array, :headers => headers )
    end
  end

  def search(input)
    puts "Your Query: #{input}"
    puts self.catalog.select{|k, v|
      v.to_s.include?input}
  end
end

dex_config = {path:'*.csv', headers: true, include_headers:true,
              converters:  [:weight_in_lbs, :diet, :all],
              header_converters: [:africa, :symbol],}

dex = Dinodex.new(dex_config)
puts dex.show_data
puts "Search for something:"
input = gets.chomp
dex.search(input)
