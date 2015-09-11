require_relative 'dino_dex'

class DinodexShell
  VALID_OPTION = /[plsaeq]/

  attr_accessor :working_directory, :dex, :file_finder

  def start_shell
    @dex = DinoDex.new
    @file_finder = FileFinder.new(".", "*.csv")
    @header_line_length   = 50
    @header_line_padding  = 2
    clear_screen
    print_header
    gets_option
  end

  private

  def print_main
    clear_screen
    print_header
  end

  def state_info
    printf("Dinosaurs:\t\t(%s)\nWorking Path:\t\t(%s)\nCSV Files Found:\t(%s)\n\n",
      @dex.dinosaurs.length.to_s,
      @file_finder.directory_path,
      @file_finder.files.length.to_s)
  end

  def state_options
    puts "COMMANDS:\t\t(P): Set Path, (L): Load CSV, (S): Search, (A): List Dinosaurs"
    puts "\t\t\t(E): Export JSON Dinosaurs, (Q): Quit DinoDex\n\n"
  end

  def print_header
    header_line(@header_line_length)
    header_line(@header_line_length, @header_line_padding, "Jurassic Park, DinoDex Interface")
    header_line(@header_line_length, @header_line_padding, "Version 4.0.5, Alpha E")
    header_line(@header_line_length)
  end

  def header_line(line_length = 40, line_padding = 0, line_str = "")
    return puts "#" * line_length if line_str == ""
    empty_space = line_length - line_str.length - (line_padding * 2)
    return puts "#" * line_length if empty_space < 0
    line_str = "##" + (" " * (empty_space / 2)) + line_str + (" " * (empty_space / 2))
    return printf(line_str + " ##\n") unless empty_space.even?
    printf(line_str + "##\n")
  end

  def print_line
    puts "*" * 80
  end

  def clear_screen
    system("clear") || system("cls")
  end

  def gets_option
    state_info
    state_options
    print "> "
    do_option(parse_option(gets))
    gets_option
  end

  def do_option(input)
    case input
      when "p"
        clear_screen
        print_header
        prompt_set_path
      when "l"
        prompt_load_csv
      when "s"
        prompt_search_dinodex
      when "a"
        list_dinosaurs
      when "q"
        stop_shell
      when "e"
        export_dinosaurs
      else
        gets_option
      end
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

  def prompt_set_path
    printf "Please specify the CSV search path or (!Q)uit: "
    input = gets.strip
    case input.downcase
      when "!q"
        print_main
      else
        if !set_working_dir(input)
          prompt_set_path
        else
          @file_finder.search
          print_main
        end
      end
  end

  def set_working_dir(dir = "")
    dir = "." if dir == ""
    unless Dir.exist?(dir)
      puts "Directory specified does not exist."
      return false
    end
    @file_finder.directory_path = dir
  end

  def search_dinodex(args)
    @dex.select_hash(args)
  end

  def prompt_search_dinodex
    clear_screen
    print_header
    if @dex.empty?
      return puts "No dinosaurs loaded into DinoDex system... Please load from CSV files first.\n\n"
    end
    puts "\nSEARCH OPTIONS: name, period, diet, weight, walking"
    puts "\nEXAMPLE: 'diet: carnivore, walking: biped, weight: <2000'"
    puts "\nPlease enter search parameters in new ruby hash form or (!Q)uit"
    input = gets.strip
    case input.downcase
      when "!q"
        print_main
      else
        clear_screen
        print_header
        puts "\nDinosaur Search Results:\n-----"
        search_hash = parse_search_options(input)
        @dex.select_hash(search_hash).print_data(search_hash.keys.unshift("name"))
        print_line
        puts "\n\n"
      end
  end

  def parse_search_options(params)
    params.delete(' ').delete("\t").split(',').each_with_object({}) do |param, args|
      param = param.split(':')
      args[param[0].to_sym] = param[1]
    end
  end

  def prompt_load_csv
    puts "Loading CSV files from working path..."
    @file_finder.search
    if file_finder.files.length == 0
      clear_screen
      print_header
      puts "No CSV files found in current directory. Try changing the path and load again.\n\n"
    else
      clear_screen
      print_header
      puts "Found #{file_finder.files.length} CSV Files"
      file_finder.files.each { |filename| puts "-- #{filename}" }
      puts "Loading Dinosaurs..."
      file_finder.files.each { |file_path| dex.import_csv_file(file_path) }
      puts "Added #{dex.dinosaurs.length} Dinosaurs to DinoDex System\n\n"
    end
  end

  def request_csv_path
    printf "Please specify the CSV search path:"
    request_csv_path unless set_working_dir(gets.strip)
    puts "Directory path set to: #{working_directory}"
  end

  def export_dinosaurs
    clear_screen
    print_header
    if @dex.empty?
      return puts "No dinosaurs loaded into DinoDex system... Please load from CSV files first.\n\n"
    end
    puts "#{@dex.export_json}\n\n\n"
  end

  def list_dinosaurs
    clear_screen
    print_header
    if @dex.empty?
      return puts "No dinosaurs loaded into DinoDex system... Please load from CSV files first.\n\n"
    end
    puts "Listing All DinoDex Registered Dinosaurs:"
    @dex.dinosaurs.each do |dinosaur|
      dinosaur.print_facts
      puts "\n-----\n"
    end
  end

  def stop_shell
    clear_screen
    print_header
    abort("\nExiting DinoDex Interface... Goodbye\n\n")
  end
end
DinodexShell.new.start_shell
