#!/usr/bin/env ruby

require 'hirb'

require_relative 'importer'
require_relative 'converter'
require_relative 'rolodex'
require_relative 'dinosaur'

class DinoDex
  attr_accessor :options

  def initialize(config = {})
    extend Hirb::Console
    setup_options(config)
    start_dinodex
  end

  def big(data_set)
    data_set.select do |_name, dinosaur|
      dinosaur.weight.to_i > 2000
    end
  end

  def small(data_set)
    data_set.select do |_name, dinosaur|
      dinosaur.weight.to_i <= 2000
    end
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
    @rolodex = Rolodex.new(Dinosaur::HEADERS, self)
    display_title
    execute_command_loop
  end

  def display_title
    puts ('-' * 30) << "\nDINODEX\n" << ('-' * 30)
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
  end

  def help
    puts
    puts "The following commands are available:\n\n"
    puts "list:\t\tDisplay a list of all data."
    puts "details:\tDisplay a list that you can select data from."
    puts "query:\t\tGo into query mode."
    puts "quit:\t\tquit the application."
    puts
  end

  def list
    table(@data.data_set.values, fields: Dinosaur.headers)
  end

  def details
    list = menu(@data.data_set.values, fields: Dinosaur.headers)
    item = @rolodex.show_details(@data.data_set, *list)
    table(item.values, fields: Dinosaur.headers)
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
    if results.empty?
      puts 'No results found with your criteria.'
    else
      table(results.values, fields: Dinosaur.headers)
    end
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
