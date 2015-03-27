class Dinodex_Wizard

  # this acts as an interactive interface for the dinodex class

require_relative 'dinodex'
require 'pp'

def self.check_args(args)
  if args == []
    abort("Please include CSV files as arguments. Exiting...")
  end
end

def self.prompt_user_for_constraint

  joe_format = ["NAME","PERIOD","CONTINENT","DIET","WEIGHT_IN_LBS","WALKING","DESCRIPTION"]

  puts "Valid fields listed below:\n#{joe_format}"
  puts "Please type a field to search and the value to look for, separated by ="
  puts "{ex: name = velociraptor}"

  input = STDIN.gets.split("=", 2)

  if input.count != 2
    abort("You aren't paying attention to the format at all. I bet you don't even like dinosaurs. Get out of here.")
  end

  input.each do |x|
    x.strip!
  end

  unless joe_format.include? input[0]
    abort("That's not a valid field. I bet you don't even like dinosaurs. Get out of here.")
  end
  return input
end

def self.prompt_user_for_constraints

  filter_further = true
  constraints = []

  while filter_further
    puts "add a constraint? (y/n)"
    input = STDIN.gets.strip.downcase
    if input == "y" 
      constraints << prompt_user_for_constraint
    else
      filter_further = false
    end
  end
  return constraints
end

def self.choose_function
  puts "Select function to run:\nQUERY\nBIG\nSMALL\n\n"
  input = STDIN.gets.strip.downcase
end

def self.run(files)
  check_args(files)
  dex = Dinodex.new(files)
  pp dex.array_of_dinos
  pp "Here's the entire set."
  choice = choose_function
  case choice
  when "query"
    constraints = prompt_user_for_constraints
    pp dex.filter_by_strings(constraints)
  when "big"
    pp dex.get_big_dinos
  when "small"
    pp dex.get_small_dinos
  end
end

end

Dinodex_Wizard.run(ARGV)
