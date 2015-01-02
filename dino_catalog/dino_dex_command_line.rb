class DinoDexCommandLine
  def initialize(joes_csv, pirate_bay_csv)
    @dino_dex = DinoDex.new([joes_csv, pirate_bay_csv])
    @help_doc = File.read("dino_rules.txt")
    puts "\nWelcome to the DinoDex!\n\n"\
    "Available comands: \nexit \nprint_all_dinos \nprint_help_menu"\
    "\n[dino_name] \nfilter [filter1] [filter2] ..."
    loop { get_input }
  end

  private

  def get_input
    puts "\nEnter command (type \"help\" for command documentation"\
    " or a blank line to quit): \n"
    user_input = gets.chomp.strip.downcase.split
    process_input(user_input)
  end

  def process_input(user_input)
    exit unless user_input.length > 0
    if user_input.length == 1
      process_single_command(user_input[0])
    else
      process_filters(user_input)
    end
  end

  def process_single_command(user_input)
    if %w( print_all_dinos print_help_menu ).include?(user_input)
      send(user_input)
    elsif @dino_dex.to_a.include?(user_input)
      print_all_dino_facts(user_input)
    else
      invalid_command
    end
  end

  def process_filters(user_inputs)
    if user_inputs[0] != "filter"
      invalid_command
    else
      print_filtered_dinos(user_inputs[1..-1])
    end
  end

  def print_help_menu
    puts "#{@help_doc}"
  end

  def print_all_dinos
    puts @dino_dex.to_a
  end

  def print_all_dino_facts(dino_name)
    puts @dino_dex.find_dino(dino_name).to_s
  end

  def print_filtered_dinos(filters)
    filtered_dinos = @dino_dex.filter_dinos(filters)
    if filtered_dinos
      filtered_dinos.each { |dino| puts dino.name }
    else
      puts "Please enter at least one valid filter."
    end
  end

  def invalid_command
    puts "Invalid command.  Please try again."
  end
end
