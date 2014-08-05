#!/usr/bin/env ruby
# File dinodex.rb
require 'csv'
require 'hirb'
require './csv_converters'
require './dinosaur'
require './search_catalog'

class Dinodex
  attr_accessor :catalog, :search_klass



  def initialize(config = {}, search = nil)
    self.catalog = {}
    self.search_klass = search
    options = {
        :path => config[:path] || '*.csv',
        :headers => config[:include_headers] || true,
        :header_converters => config[:header_converters] || [],
        :converters => config[:converters] || []
    }

    process_csv(options)
  end

  def show_data
    display_array = []
    catalog.values.each { |dinosaur| display_array << dinosaur.table_display }
    puts Hirb::Helpers::AutoTable.render(display_array, :headers => Dinosaur::HEADERS)
  end

  def search(input)
    puts "You Searched For: #{input}"
    if input.to_s.include?(',')
      search_terms = input.to_s.downcase.split(',')
    else
      search_terms = input.to_s.downcase.split(' ')
    end

    search_klass.search(catalog, search_terms)

  end

  private
  def process_csv(options ={})
    file_path = options.delete(:path)
    Dir.glob(file_path).each do |file|
      create_dinosaurs(CSV.read(file, options))

    end
  end

  def create_dinosaurs(initial_table)
    initial_table.by_row.each do |dino|
      ops = {}
      initial_table.headers.each do |header|
        ops[header] = dino[header]
      end
      catalog[ops[:name]] = Dinosaur.new(ops)
    end
  end

end

dex_config = {path: '*.csv', headers: true, include_headers: true,
              converters: [:weight_in_lbs, :diet, :all],
              header_converters: [:africa, :symbol], }

search = SearchCatalog.new(Dinosaur::HEADERS)
dex = Dinodex.new(dex_config, search)
puts dex.show_data
puts 'Search for something:'
input = gets.chomp
while input.to_s.downcase != 'exit'
  exit if input.to_s.downcase == 'n'
  dex.search(input)
  puts 'Search again? (Y/n)'
end
