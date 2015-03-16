#!/usr/bin/env ruby

require_relative "dino_csv_parser"
require_relative "dino_catalog"
require_relative "dino_printer"

class DinoApp
  ACTIONS = {
    print: :print_results,
    find: :find,
    export: :export,
    quit: :quit,
  }

  def initialize
    @parser = DinoCsvParser.new
    @catalog = DinoCatalog.new
    @printer = DinoPrinter.new

    show_welcome
  end

  def run
    load_all_csv_files

    loop do
      show_prompt
      handle_input(input)
    end
  end

  private

  def load_all_csv_files
    dinos = []
    Dir["./*.csv"].each do |filename|
      dinos << @parser.parse_file(filename)
    end
    @catalog.dinos = dinos.flatten!
  end

  def show_prompt
    puts ""
    print "Enter command> "
  end

  def input
    gets.chomp
  end

  def handle_input(input)
    args = input.split(" ", 2)
    command = (args[0] || "").to_sym
    params = args[1] ? args[1] : ""
    action = ACTIONS.fetch(command, :show_help)
    send(action, params)
  end

  def print_results(params)
    if params.downcase == "all"
      @printer.display_dinos(params, @catalog.dinos)
    else
      @printer.display_dinos(params, @catalog.results)
    end
  end

  def find(params)
    @catalog.find(params)
    @printer.display_results(@catalog.results)
  end

  def export(_)
    json = @catalog.to_json
    puts json
  end

  def quit(_)
    exit
  end

  def show_welcome
    puts "*********************"
    puts "* Dino Catalog v1.0 *"
    puts "*********************"
  end

  def show_help(_)
    help = <<-HEREDOC
Available commands: find, print, export, quit

Usage:
=> find category1=val1, ... , categoryN=valN
   Find dinos matching the specified criteria (case insensitive)
   category can be one of NAME, PERIOD, CONTINENT, DIET, WEIGHT, WALKING

   For the WEIGHT category, val can be one of the following:
     integer - will search for an exact match
     'big'   - will search for dinosaurs > 2 tons
     'small' - will search for dinosaurs <= 2 tons

=> print all
   Print dino data for all dinos in the catalog

=> print
   Print dino data for the results of a find operation

=> export
   Display dino data in JSON format

=> quit
   Quit the program
    HEREDOC

    puts help
  end
end

app = DinoApp.new
app.run
