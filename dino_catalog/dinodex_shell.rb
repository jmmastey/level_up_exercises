require_relative 'dinodex'

class DinodexShell
  load = -> { prompt_load_csv }
  search = -> { prompt_search_dinodex }
  list = -> { list_dinosaurs }
  quit = -> { stop_shell }

  DISPATCHER = {
    "l" => load,
    "s" => search,
    "a" => list,
    "q" => quit,
  }

  VALID_OPTION = /[lsaq]/

  def self.start_shell(filenames = [])
    @dex = Dinodex.new
    puts "Welcome to DINODEX!"
    filenames.each { |filename| load_csv(filename) }
    gets_option
  end

  def self.stop_shell
    abort("Thanks for using DINODEX!")
  end

  def self.gets_option
    state_options
    print "Choose an option: "
    do_option(parse_option(gets))
    gets_option
  end

  def self.state_options
    puts "\nOPTIONS: (L): Load CSV, (S): Search, (A): List Dinosaurs, (Q): Quit"
  end

  def self.parse_option(input)
    input = input.strip.downcase
    return unless valid_option?(input)
    input
  end

  def self.valid_option?(input)
    valid = VALID_OPTION =~ input
    return true if valid
    puts "Not a valid option."
    false
  end

  def self.do_option(input)
    DISPATCHER[input].call
  end

  def self.prompt_load_csv
    puts "Please enter the name of the file you'd like to load:"
    filename = gets.strip
    load_csv(filename)
  end

  def self.load_csv(filename)
    @dex.load_csv(filename)
  end

  def self.list_dinosaurs
    @dex.to_s
  end

  def self.prompt_search_dinodex
    puts "\nSEARCH OPTIONS: name, period, diet, big, small, weight, walking"
    puts "       EXAMPLE: 'diet: carnivore, walking: biped, big: true'"
    puts "\nPlease enter search parameters in new ruby hash form"
    search_dinodex(parse_search_options(gets.strip))
  end

  def self.search_dinodex(args)
    @dex.print_search(args)
  end

  def self.parse_search_options(params)
    params.delete(' ').split(',').each_with_object({}) do |param, args|
      param = param.split(':')
      args[param[0].to_sym] = param[1]
    end
  end
end

DinodexShell.start_shell
