require 'table_print'
class Printer
  def self.print_options
    puts "WELCOME TO DINODEX\nA repository for amazing Dinosaur knowledge"
    print_filters
    print_commands
    puts "\nWhat would you like to do? "
  end

  def self.print_filters
    puts "\n\nFILTERS"
    puts "--------------------------------------"
    puts "Bipeds type 'bipeds'"
    puts "Carnivore type 'carnivores'"
    puts "Over 2 tons type 'big'"
    puts "By time period type 'period'"
  end

  def self.print_commands
    puts "\nCommands"
    puts "--------------------------------------"
    puts "To Reset filters type 'reset'"
    puts "Search for specific Dino type 'search'"
    puts "To print current filtered results type 'print'"
    puts "To Quit type 'q'"
  end

  def self.print(results)
    tp results
    STDIN.gets
  end

  def self.eras(era)
    puts 'Available Periods:'
    era.each { |period| puts period }
    puts 'Which Period would you like to see Dinos from?'
  end
end
