#!/usr/bin/env ruby
# File dinodex.rb

require 'csv'
require 'hirb'
require './csv_converters'
require './dinosaur'
require './search_catalog'
require 'awesome_print'


class Dinodex
  attr_accessor :catalog, :search_klass




  def initialize(config = {}, search = nil)
    extend Hirb::Console
    self.catalog = {}
    self.search_klass = search
    options = {
        :path => config[:path] || '*.csv',
        :headers => config[:include_headers] || true,
        :header_converters => config[:header_converters] || [],
        :converters => config[:converters] || []
    }

    process_csv(options)
    show_app_title
  end

  def show_app_title
    puts "*"*20 + " DinoSearch - 5000 " + "*"*20
  end

  def choose_info
    # display_array = []
    # catalog.values.each { |dinosaur| display_array << dinosaur.table_display }
    # puts Hirb::Helpers::AutoTable.render(display_array, :headers => Dinosaur::HEADERS)
    menu catalog.values, :fields=> Dinosaur.fields, :two_d=>true, :action=>true, :action_object=>self
  end

  def back(input)
    'back'
  end

  def info(input)
     selected = search_klass.show_info(catalog, *input)
     table selected.values, :fields => Dinosaur.fields
     puts 'Do you wish to contine? yes/no'
     answer = gets.chomp

  end

  def search(input)
    puts "You Searched For: #{input}"
    if input.to_s.include?(',')
      search_terms = input.to_s.downcase.split(',')
    else
      search_terms = input.to_s.downcase.split(' ')
    end

    search_klass.search(catalog, *input)

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

def available_commands
  puts 'Available Commands: search | info | exit'
  puts '-'*40
  puts "search:\tTo search through the catalog"
  puts "info:\tDisplays all entries, and allows you to select any entry for more information"
  puts "exit:\tTo exit the application"
  puts '-'*40
  print 'Enter a command: '
  gets.chomp
end
command = available_commands


while command != 'exit'
  if command == 'search'

  end
  if command == 'info'
    choices = dex.choose_info
    if choices == 'back'
      command = available_commands
    end
  end
end


