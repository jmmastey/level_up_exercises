class DinodexWizard
  require_relative 'dinodex'
  require 'pp'

  SUPPORTED_FIELDS = [
    "NAME",
    "PERIOD",
    "CONTINENT",
    "DIET",
    "WEIGHT_IN_LBS",
    "WALKING",
    "DESCRIPTION"
  ]

  def self.check_args(args)
    if args == []
      abort("Please include CSV files as arguments. Exiting...")
    end
  end

  def self.prompt_user_for_constraint
    puts "Valid fields listed below:\n#{SUPPORTED_FIELDS}"
    puts "Please type a field to search and the value to look for, separated by ="
    puts "{ex: name = velociraptor}"

    input = STDIN.gets.split("=", 2)

    abort("You aren't paying attention") unless input.count == 2

    input.each do |x|
      x.strip!
    end

    return input if SUPPORTED_FIELDS.include? input[0]
    abort("That's not a valid field.")
  end

  def self.prompt_user_multiple_constraints(constraint_array = [])
    constraint_array << prompt_user_for_constraint
    puts "add a constraint? (y/n)"
    input = STDIN.gets.strip.downcase
    if input == "y"
      prompt_user_multiple_constraints(constraint_array)
    else
      constraint_array
    end
  end

  def self.choose_function
    puts "Select function to run:\nQUERY\nBIG\nSMALL\nCARNIVORES\n"
    STDIN.gets.strip.downcase
  end

  def self.run(files)
    check_args(files)
    dex = Dinodex.new(files)
    pp dex.array_of_dinos
    pp "Here's the entire set."
    choice = choose_function
    case choice
      when "query"
        constraints = prompt_user_multiple_constraints
        pp dex.filter_by_strings(constraints)
      when "big"
        pp dex.big_dinos
      when "small"
        pp dex.small_dinos
      when "carnivores"
        pp dex.carnivores
      else
        abort("You're not even reading the instructions. Get out of here.")
    end
  end
end

DinodexWizard.run(ARGV)
