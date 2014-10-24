require 'pry'
require_relative 'csv_modifier'
require_relative 'filters'

class App
  include CsvModifier
  include Filters

  CARNIVORES = ['Carnivore', 'Insectivore', 'Piscivore']

  def initialize(name)
    @app_name = name
  end

  def normalize_csv_file(csv_file)
    normalize_csv_headers(csv_file)
  end

  def create_dinosaur_entry(name, attributes)
    Dinosaur.new(name, attributes)
  end

  def create_catalog(filepath)
    Catalog.new(filepath)
  end

  def launch!(csv_filename)
    normalize_csv_file(csv_filename)
    @catalog = create_catalog("normalized_csv_file.csv")
    obtain_user_filters
  end

  def obtain_user_filters
    action = nil
    until action == :back
      puts "\n\nWhat would you like to do?\n"
      puts "1. To list dinosaurs that were bipeds, enter 'Bipeds'."
      puts "2. To list dinosaurs that were carnivores, enter 'Carnivores'."
      puts "3. To list dinosaurs of a specific period, enter 'period' followed by the period you want, such as 'Period Jurassic'."
      puts "4. To list only big or small dinosaurs, enter 'big' or 'small'.\n"
      #puts "To go back import a new CSV file, enter 'back'."
      puts "To exit this program, enter 'quit'\n"
      print " > "
      user_input = gets.chomp
      formatted_action_arguments = format_user_input(user_input)
      action = do_action(formatted_action_arguments)
    end
  end

  def format_user_input(input)
    action, arguments = input.downcase.strip.split(' ')
  end

  def do_action(action)
    case action[0]
    when 'bipeds'
      list_bipeds
    when 'carnivores'
      list_carnivores
    when 'period'
      list_period(action[1])
    when 'big'
      list_size(action[0])
    when 'small'
      list_size(action[0])
    when 'back'
      return :back
    when 'quit'
      puts "\n\nExiting.\n\n"
      exit!
    else
      "I don't understand. Please enter a valid input."
    end
  end

end
