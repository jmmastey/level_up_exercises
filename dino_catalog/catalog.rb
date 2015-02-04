require_relative 'dino_list'
class Catalog
  attr_accessor :dino_list, :original_dino_list

  def initialize(csv)
    self.dino_list = DinoList.new
    self.original_dino_list = DinoList.new

    self.dino_list.load_csv(csv)
    self.original_dino_list = self.dino_list.copy
  end

  def run
    done = false

    while !done
      puts ["Enter your choice(s): ",
            "Bipeds - Display all bipeds",
            "Carnivores - Display all carnivores",
            "Time Period - Display all from a specified time period",
            "Big - Display all big dinos",
            "Small - Display all small dinos",
            "Select - Select one dion to view",
            "Reset - Remove all filter",
            "Exit - quit program",
            "You can also hit enter to view current list again"].join("\n")

      user_input = $stdin.gets.chomp.downcase
      done = true and next if user_input == 'exit'

      process_filters(user_input)
      puts dino_list.pretty_print

    end
  end

  def process_filters(user_input)
    dino_list.reset(original_dino_list) if user_input.include?('reset')

    dino_list.get_bipeds if user_input.include?('bipeds')
    dino_list.get_carnivores if user_input.include?('carnivores')

    if user_input.include?('time period')
      puts "Enter the time period you would like to view: "
      period_input = $stdin.gets.chomp.downcase
      dino_list.get_from_period(period_input)
    end

    dino_list.get_big if user_input.include?('big')
    dino_list.get_small if user_input.include?('small')

    if user_input.include?('select')
      puts "Please enter a dinosaur's name/genus: "
      name_input = $stdin.gets.chomp.downcase

      dino_list.get_by_name(name_input)
    end
  end
end
