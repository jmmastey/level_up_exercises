require 'pry'

class App

  CARNIVORES = ['Carnivore', 'Insectivore', 'Piscivore']

  def initialize(name)
    @filepath = File.join(APP_ROOT, name)
    @app_name = name
    check_file(@filepath)
    @catalog = create_catalog(@filepath, @app_name)
  end

  def check_file(filepath)
    if filepath && File.exists?(filepath)
      puts "\nA file was found!"
    else
      raise IOError, "No file was found."
    end
  end

  def create_catalog(filepath, name)
    Catalog.new(filepath, name)
  end

  def launch!
    action = nil
    until action == :back
      print "\n\nWhat would you like to do?\n\n"
      print "1. To list dinosaurs that were bipeds, enter 'Bipeds'.\n"
      print "2. To list dinosaurs that were carnivores, enter 'Carnivores'.\n"
      print "3. To list dinosaurs of a specific period, enter 'period' followed by the period you want, such as 'Period Jurassic'.\n"
      print "4. To list only big or small dinosaurs, enter 'big' or 'small'.\n\n"
      print "To go back import a new CSV file, enter 'back'.\n"
      print "To exit this program, enter 'quit'\n\n"
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
    when 'big' || 'small'
      # size search
    when 'back'
      return :back
    when 'quit'
      puts "\n\nExiting.\n\n"
      exit!
    else
      "I don't understand. Please enter a valid input."
    end
  end

  def list_bipeds
    bipeds = @catalog.dinosaurs.select { |dinosaur| dinosaur.walking == 'Biped' }
    print "\nThe following dinosaurs are bipeds: \n\n"
    print "Sorry. No bipeds were found" if bipeds.empty?
    bipeds.each do |dinosaur|
      puts "#{dinosaur.name}"
    end
  end

  def list_carnivores
    carnivores = @catalog.dinosaurs.select { |dinosaur| CARNIVORES.include?(dinosaur.diet) }
    print "\nThe following dinosaurs are Carnivores, Insectivores, or Piscivores: \n\n"
    print "Sorry. No bipeds were found" if carnivores.empty?
    carnivores.each do |dinosaur|
      puts "#{dinosaur.name}"
    end
  end

end
