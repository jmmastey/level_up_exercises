require 'pry'

class App

  def initialize(name)
    @filepath = File.join(APP_ROOT, name)
    @app_name = name
    check_file(@filepath)
    @catalog = create_catalog(@filepath, @app_name)
  end

  def check_file(filepath)
    if filepath && File.exists?(filepath)
      puts "I found a file!"
    else
      raise IOError, "No file was found"
    end
  end

  def create_catalog(filepath, name)
    Catalog.new(filepath, name)
  end

  def launch!
    action = nil
    until action == :quit
      print "What would you like to do?\n"
      print "To list dinosaurs that were bipeds, enter 'Bipeds'.\n"
      print "To list dinosaurs that were carnivores, enter 'Carnivores'.\n"
      print "To list dinosaurs of a specific period, enter 'period' followed by the period you want, such as 'Period Jurassic'.\n"
      print "To list only big or small dinosaurs, enter 'big' or 'small'.\n"
      print " > "
      user_input = gets.chomp
      formatted_action = format_user_input(user_input)
      action = do_action(formatted_action)
    end
  end

  def format_user_input(input)
    input.downcase.strip
  end

  def do_action(action)
    case action
    when 'bipeds'
      list_bipeds
    when 'carnivores'
      # carnivore search
    when 'period'
      # period search
    when 'big' || 'small'
      # size search
    when 'quit'
      return :quit
    else
      "I don't understand. Please enter a valid input."
    end
  end

  def list_bipeds
    bipeds = @catalog.dinosaurs.select { |dinosaur| dinosaur.walking == 'Biped' }
    print "The following dinosaurs are bipeds: \n\n"
    print "Sorry. No bipeds were found" if bipeds.empty?
    bipeds.each do |dinosaur|
      puts "#{dinosaur.name}"
    end
  end

end
