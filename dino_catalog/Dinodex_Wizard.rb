class Dinodex_Wizard

require_relative 'dinodex'
require 'pp'

@Dinodex = Dinodex.new

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

def run(files){

  check_args(args)


}

    dinodex = Dinodex.new
    dinodex.check_args(ARGV)
    array_of_dinos = DinoConverter.csv_files_to_dino_array(ARGV)
    pp array_of_dinos # it's really not that pretty, ruby.
    p "Here's the entire set."
    dinodex.filter_loop(array_of_dinos)

end

Dinodex_Wizard.run_via_console