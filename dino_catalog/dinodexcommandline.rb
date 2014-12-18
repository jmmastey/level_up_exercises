module DinoDexCommandLine
  
  def get_and_check_input
    
    puts "Enter command (type \"help\" for list of commands): \n"
    user_input = []
    user_input = gets.chomp.strip.split

    if user_input == []
      puts "Invalid command.  Please try again."
      get_and_check_input
    end
    
    if user_input.length == 1
      
      if user_input[0].eql? "help"
        file = File.open("dinorules.txt", "r")
        contents = file.read
        puts contents + "\n"
        get_and_check_input
        
      elsif user_input[0].downcase.eql? "all_dinos"
        puts "\nLIST OF ALL DINOS:"
        $dino_dex.all_dinos
        puts "\n"
        get_and_check_input
        
      elsif $dino_names_array.include? user_input[0].downcase
        puts "\n"
        $dino_dex.print_all_facts(user_input[0])
        puts "\n"
        get_and_check_input
        
      elsif user_input[0].downcase.eql? "exit"
        return
        
      else
        puts "Invalid command.  Please try again."
        get_and_check_input
      end
    end
    
    if user_input.length > 1
      
      if user_input[0].downcase != "filter"
        puts "Invalid command.  Please try again."
        get_and_check_input
        
      else
        $dino_dex.filter_dinos(user_input[1..-1])
        puts "\n"
        get_and_check_input      
      end
    end
  end
end
