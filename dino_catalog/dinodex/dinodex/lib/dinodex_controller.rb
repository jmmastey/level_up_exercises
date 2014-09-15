require "dinosaur"
require "dinodex_loader"
require "dinodex_filter"
require "dinodex_display"

class DinodexController
  include DinodexDisplay

  COMMAND_MAP = {
    "d" => :filter_and_detail_name,
    "k" => :key_display,
    "l" => :list_display,
    "f" => :filter_and_display,
    "g" => :filter_and_detail,
    "j" => :filter_and_json,
    "?" => :help_display,
    "h" => :help_display,
    "q" => :quit
  }

  MENU = <<-MENU
d [name]          detailDisplay     show all details of the dinosaur [name],
                                    "d Abrictosaurus"
f [key=value]|... filterAndDisplay  show the names of the dinosaurs that have
                                    the matching
                                    key and value, "f walking=biped". Multiple
                                    with pipe
                                    delimiting, like
                                    "f walking=biped|diet=omnivore"
g [key=value]|... filterAndDetail   same as "f", but shows details instead of
                                    just name
j [key=value]|... filterAndJSON     same as "f", but shows JSON
k                 keyDisplay        show all the dinosaur attributes for
                                    filtering
l                 listDisplay       show all dinosaur names
q                 quit
?, h              help
  MENU

  attr_accessor :dinosaurs, :csv_files

  def initialize(output)
    @output = output
    @dinosaurs = []
    @csv_files = []
    @filter = DinodexFilter.new
  end

  def start(directory)
    @output.puts "Finding CSV files in #{directory}"
    @dinodex_loader = DinodexLoader.new
    @csv_files = @dinodex_loader.find_csv_files(directory)
    @csv_files.each do |file|
      @dinodex_loader.load_csv_file("#{directory}/#{file}").each do |dino|
        @dinosaurs.push(dino)
      end
    end
  end

  def interaction
    @output.puts "Welcome to Dinodex"
    interaction_loop
    @output.puts "Goodbye"
  end

  def interaction_loop
    loop do
      command, input = collect_user_input
      if COMMAND_MAP[command].nil?
        @output.puts "invalid selection, try again"
        next
      end
      break if COMMAND_MAP[command] == :quit
      interaction_execute(command, input)
    end
  end

  def interaction_execute(command, input)
    if input.nil?
      send(COMMAND_MAP[command])
    else
      send(COMMAND_MAP[command], input)
    end
  end

  def collect_user_input
    @output.puts "Enter your selection: (h for help)"
    selection      = gets.chomp
    selection.split(" ", 1)
  end

  def help_display
    @output.puts MENU
  end

  def key_display
    @output.puts "Keys available: name, period, diet, weight, walking, " \
      "description, continent"
  end
end
