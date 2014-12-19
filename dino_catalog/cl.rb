
module DinoDexCommandLine


  def get_input
    puts "\nEnter command (type \"help\" for list of commands or \"exit\" to quit): \n"
    user_input = []
    user_input = gets.chomp.strip.downcase.split
    process_input_length(user_input)
  end
  
  def process_input_length(user_input)
    case
    when user_input.length == 0
      invalid_command
    when user_input.length == 1
      process_nonfilter_input(user_input[0])
    else 
      process_filter_input(user_input)
    end
  end
  
  def process_nonfilter_input(user_input)
    case user_input
    when "all_dinos" 
      print_all_dinos
    when "help" 
      print_help_menu
    when "exit" 
      exit_program
    when *$dino_names 
      print_all_dino_facts(user_input)
    when "filter" 
      puts "Please specify at least one filter."
    else 
      invalid_command
    end
  end
  
  def process_filter_input(filter_input)
    if filter_input[0] != "filter"
      invalid_command
    else
    print_filtered_dinos(filter_input[1..-1])
    end
  end
  
  def print_help_menu
    file = File.open("dino_rules.txt", "r")
    help_doc = file.read
    puts "#{help_doc} \n"
  end
  
  def print_all_dinos
    puts "\nLIST OF ALL DINOS: \n"
    puts $dino_dex.all_dinos
    puts "\n"
  end
  
  def print_all_dino_facts(dino_name)
    puts $dino_dex.print_all_facts(dino_name)
  end
  
  def exit_program
    exit
  end
  
  def print_filtered_dinos(filters)
    $dino_dex.filter_dinos(filters)
    puts "\n"
  end
  
  def invalid_command
    puts "Invalid command.  Please try again."
  end
end