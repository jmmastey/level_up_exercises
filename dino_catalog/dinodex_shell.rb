require_relative 'dinodex'

class DinodexShell
  VALID_OPTION = /[lsaq]/

  def start_shell(filenames = [])
    @dex = Dinodex.new
    puts "Welcome to DINODEX!"
    filenames.each { |filename| load_csv(filename) }
    gets_option
  end

  def gets_option
    state_options
    print "Choose an option: "
    do_option(parse_option(gets))
    gets_option
  end

  def state_options
    puts "\nOPTIONS: (L): Load CSV, (S): Search, (A): List Dinosaurs, (Q): Quit"
  end

  def parse_option(input)
    input = input.strip.downcase
    return unless valid_option?(input)
    input
  end

  def valid_option?(input)
    valid = VALID_OPTION =~ input
    return true if valid
    puts "Not a valid option."
    false
  end

  def do_option(input)
    case input
    when "l"
      prompt_load_csv
    when "s"
      prompt_search_dinodex
    when "a"
      list_dinosaurs
    when "q"
      stop_shell
    else
      gets_option
    end
  end

  def search_dinodex(args)
    @dex.print_search(args)
  end

  def parse_search_options(params)
    params.delete(' ').split(',').each_with_object({}) do |param, args|
      param = param.split(':')
      args[param[0].to_sym] = param[1]
    end
  end

  def prompt_load_csv
    puts "Please enter the name of the file you'd like to load:"
    filename = gets.strip
    @dex.load_csv(filename)
  end

  def prompt_search_dinodex
    puts "\nSEARCH OPTIONS: name, period, diet, big, small, weight, walking"
    puts "       EXAMPLE: 'diet: carnivore, walking: biped, big: true'"
    puts "\nPlease enter search parameters in new ruby hash form"
    search_dinodex(parse_search_options(gets.strip))
  end

  def list_dinosaurs
    @dex.to_s
  end

  def stop_shell
    abort("Thanks for using DINODEX!")
  end
end
