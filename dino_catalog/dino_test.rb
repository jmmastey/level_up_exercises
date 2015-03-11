#!/usr/bin/env ruby

require_relative 'dino_catalog'

def show_help
  puts ""
  puts "Available commands: find, print, verbose, exit"
  puts ""
  puts "Usage:"
  puts "=> find category1=val1, ... , categoryN=valN"
  puts "   Find dinos matching the specified criteria (case insensitive)"
  puts "   category can be one of " \
       "NAME, PERIOD, CONTINENT, DIET, WEIGHT, WALKING"
  puts ""
  puts "   For the WEIGHT category, val can be one of the following:"
  puts "     integer - will search for an exact match"
  puts "     'big'   - will search for dinosaurs > 2 tons"
  puts "     'small' - will search for dinosaurs <= 2 tons"
  puts ""
  puts "=> print all"
  puts "   Print dino data for all dinos in the catalog"
  puts ""
  puts "=> print"
  puts "   Print dino data for the results of a find operation"
  puts ""
  puts "=> exit"
  puts "   Exit the program"
  puts ""
end

puts "*********************"
puts "* Dino Catalog v1.0 *"
puts "*********************"

dc = DinoCatalog.new

loop do
  puts ""
  print "Enter command> "

  input = gets.chomp
  args = input.split(" ", 2)

  command = args[0] ? args[0] : ""
  params = args[1] ? args[1] : ""

  case command
    when "print"
      dc.print_results(params)
    when "find"
      dc.find(params)
    when "exit"
      exit
    else
      show_help
  end
end
