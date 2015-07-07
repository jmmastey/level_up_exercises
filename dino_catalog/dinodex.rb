#!/usr/bin/env ruby

require 'hirb'

require_relative 'importer'
require_relative 'converter'
require_relative 'rolodex'
require_relative 'dinosaur'

DINODEX_HELP = <<TEXT
--------------------------------------------------------------------------
The following commands are available:

list:    Display a list of all data.
details: Display a list that you can select data from.
query:   Go into query mode.
quit:    Quit the application.

Query mode is a special interface that lets you search
the data. To exit query mode:

exit:    Exits query mode.

While in query mode, you can perform queries based on a column. You must use
the format below.

    movement=Biped

Please do not use spaces in these queries. You can chain such queries, if
you wish.

    period=Jurassic, continent=Europe

You can also perform text queries. The same examples from above would be:

    "Biped"
    "Jurassic", "Europe"

Do note that text queries must be in single or double quotes.

There are certain qualifier terms you can use to query on. Currently the
known qualifiers that DinoDex responds to are:

    big
    small

You can combine criteria and chain filter calls together. For example:

    period=Jurassic,"Carnivore"
    "Europe",big,"Biped"
--------------------------------------------------------------------------

TEXT

class DinoDex
  attr_accessor :options

  def initialize(config = {})
    extend Hirb::Console
    setup_options(config)
    start_dinodex
  end

  private

  def setup_options(config)
    @options = {
      path: config[:path] || 'data/*.csv',
      headers: true,
      converters: config[:converters] || Converter.dino_data_convert,
      header_converters: config[:header_converters] || Converter.header_convert,
    }
  end

  def start_dinodex
    create_file_path
    @data = Importer.new(options, Dinosaur)
    @rolodex = Rolodex.new(Dinosaur::HEADERS, Dinosaur)
    display_title
    execute_command_loop
  end

  def display_title
    puts('-' * 70)
    puts "DINODEX"
    puts "Type help for more details."
    puts('-' * 70)
  end

  def execute_command_loop
    loop do
      print 'DinoDex $ '
      command = gets.chomp
      exit if command == 'quit'
      execute_command(command)
    end
  end

  def execute_command(command)
    send command.to_sym
  rescue NoMethodError
    puts "There is no command '#{command}'."
    puts "Type help for available commands.\n"
  end

  def help
    puts DINODEX_HELP
  end

  def list
    table(@data.data_set.values, fields: Dinosaur.columns)
  end

  def details
    list = menu(@data.data_set.values, fields: Dinosaur.columns)
    item = @rolodex.show_details(@data.data_set, *list)
    table(item.values, fields: Dinosaur.columns)
  end

  def query
    conditions = ''
    loop do
      print 'DinoDex <Query Mode> $ '
      conditions = gets.chomp
      break if conditions == 'exit'
      present_results(conditions)
    end
  end

  def present_results(conditions)
    results = @rolodex.query(@data.data_set, conditions)
    return puts 'No results found with your criteria.' if results.empty?
    table(results.values, fields: Dinosaur.columns)
  end

  def create_file_path
    return unless File.extname(options[:path]).empty?
    @options[:path] += '/' unless ends_with_slash?(options[:path])
    @options[:path] += '*.csv' if no_extension?(options[:path])
  end

  def no_extension?(path)
    File.extname(path).empty?
  end

  def ends_with_slash?(path)
    path.split('').last == '/'
  end
end

DinoDex.new
