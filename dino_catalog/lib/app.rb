class App

  def initialize(name)
    @filepath = File.join(APP_ROOT, name)
    @app_name = name
    check_file(@filepath)
    create_catalog(@filepath, @name)
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
    until action == (:quit || :exit)
      print "What would you like to do?\n"
      print "To list dinosaurs that were bipeds, enter 'Bipeds'.\n"
      print "To list dinosaurs that were carnivores, enter 'Carnivores'.\n"
      print "To list dinosaurs of a specific period, enter the period, such as 'Jurassic'.\n"
      print "To list only big or small dinosaurs, enter 'big' or 'small'.\n"
      print " > "
      user_input = gets.chomp
      action = format_user_input(user_input)
      do_action(actionaction)
    end
  end



end
