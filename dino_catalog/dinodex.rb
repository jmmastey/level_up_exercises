#!/usr/bin/env ruby
# File dinodex.rb

require 'csv'
require 'hirb'
require './csv_converters'
require './dinosaur'
require './search_catalog'
# DinoDex Super Awesome Fun Time Main Class
class Dinodex
  attr_accessor :catalog, :search_klass
  AVAILABLE_COMMANDS = <<AVAILABLE_COMMANDS
Available Commands: search | info | exit
----------------------------------------
list:	To display a list of dinosaurs in
        catalog
search:	To search through the catalog
info:	Displays all entries, and allows
        you to select any entry number
        for more information
exit:	To exit the application
----------------------------------------
AVAILABLE_COMMANDS

  def initialize(config = {}, search = nil)
    extend Hirb::Console
    self.catalog = {}
    self.search_klass = search
    options = { path: config[:path] || '*.csv',
                headers: true,
                header_converters: config[:header_converters] || [],
                converters: config[:converters] || []
    }
    process_csv(options)
  end

  def show_app_title
    '*' * 20 + ' DinoSearch - 5000 ' + '*' * 20
  end

  def exit_app
    show_app_title + "\nThanks for stopping by\n"
  end

  def info
    get_info(menu catalog.values, fields: Dinosaur.fields, two_d: false,
                  action: false, action_object: self)
  end

  def list
    table catalog.values, fields: Dinosaur.fields
  end

  def search
    input = '--help'
    while input != 'exit'
      puts search_klass.search_help if input == '--help'
      print 'Query: '
      input = gets.chomp
      results = search_klass.search(catalog, input)
      query_result(results)
    end
  end

  def query_result(results)
    if results.nil?
      puts 'No results found. Please try again.'
    else
      table results.values, fields: Dinosaur.fields
    end
  end

  private

  def process_csv(options = {})
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

  def get_info(input)
    selected = search_klass.show_info(catalog, *input)
    table selected.values, fields: Dinosaur.fields
    print 'Do you wish to contine? yes/no'
    answer = gets.chomp
    'back' if answer == 'no'
  end
end

dex_config = { path: '*.csv', headers: true,
               converters: [:weight_in_lbs, :diet, :all],
               header_converters: [:africa, :symbol] }

search = SearchCatalog.new(Dinosaur::HEADERS)
dex = Dinodex.new(dex_config, search)
puts dex.show_app_title

def available_commands
  puts Dinodex::AVAILABLE_COMMANDS
  print 'Enter a command: '
  gets.chomp
end

command = available_commands
defaults = %w('exit search info list back')

while command != 'exit'
  if command == 'search'
    dex.search
    command = available_commands
  end
  if command == 'info'
    choices = dex.info
    command = available_commands if choices == 'back'
  end
  if command == 'list'
    dex.list
    command = available_commands
  end
  unless defaults.include? command
    puts "#{'*' * 40}"
    puts "COMMAND NOT RECOGNIZED: #{command}"
    puts "#{'*' * 40}"
    command = available_commands
  end
end
puts dex.exit_app
