class Dinodex_Wizard

  # this acts as an interactive interface for the dinodex class

require_relative 'dinodex'
require 'pp'

def check_args(args)
  if args == []
    abort("Please include CSV files as arguments. Exiting...")
  end
end

def prompt_user_for_constraint

  special_commands = ["SMALL","BIG"]
  joeFormat = ["NAME","PERIOD","CONTINENT","DIET","WEIGHT_IN_LBS","WALKING","DESCRIPTION"]

  puts "Valid fields listed below:"
  puts joeFormat
  puts "Please type a field to search and the value to look for, separated by a =. BIG and SMALL are special cases."
  puts "{examples: name = velociraptor, BIG, SMALL}"

  input = STDIN.gets.split("=", 2)
  return input if special_commands.include? input[0].strip

  if input.count != 2
    abort("You aren't paying attention to the format at all. I bet you don't even like dinosaurs. Get out of here.")
  end

  input.each do |x|
    x.strip!
  end

  unless joeFormat.include? input[0]
    abort("That's not a valid field. I bet you don't even like dinosaurs. Get out of here.")
  end
  return input
end

def prompt_user_for_constraints

  filter_further = true
  constraints = []

  while filter_further
    puts "add a constraint? (y/n)"
    input = STDIN.gets.strip.downcase
    if input == "y" 
      constraints += prompt_user_for_constraint
    else
      filter_further = false
    end
  end
  return constraints
end

def choose_function
  puts "Select function to run:\nQUERY\nBIG\nSMALL\n"
  input = STDIN.gets.strip.downcase
end

def run(files){

  check_args(files)
  dex = Dinodex.new(files)
  pp dex.array_of_dinos
  pp "Here's the entire set."
  choice = choose_function
  case choice
  when "query"
    constraints = prompt_user_for_constraints
    pp dex.filter_by_strings(constraints[0]. constraints[1])
  when "big"
    pp dex.get_big_dinos
  when "small"
    pp dex.get_small_dinos
  end
}

end

Dinodex_Wizard.run(ARGV)