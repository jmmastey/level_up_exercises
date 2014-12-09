require "json"
require_relative 'dinosaur_parser'
require_relative 'dinosaur_search'
require_relative 'dinosaur'
gem 'awesome_print'
require 'ap'

class DinoCatalog
  def run
    puts "PRESS 9 to exit at any time"
    comparator_options = { 1 => "equal", 2 => "greater", 3 => "lesser" }
    characteristic     = 0
    characteristic_options = { 1 => "NAME",    2 => "PERIOD", 3 => "CONTINENT",
                               4 => "DIET",    5 => "WEIGHT_IN_LBS",
                               6 => "WALKING", 7 => "DESCRIPTION"
                             }
    while (characteristic != 9)
      puts "Press characteristic to compare or PRESS 9 to exit at any time"
      ap characteristic_options
      characteristic = gets.to_i
      break if characteristic == 9

      puts "Press comarator or PRESS 9 to exit at any time"
      ap comparator_options
      comparator = gets.to_i
      break if comparator == 9

      puts "Enter value to search"
      value_to_compare = gets.chomp
      value_to_compare = sanitize_user_input(value_to_compare, characteristic)

      parsed_values = DinosaurParser.new.parse
      resultant = DinosaurSearch.new(parsed_values).filter(
                    characteristic_options[characteristic] => value_to_compare,
                    "compare" => comparator_options[comparator],
                  )
      ap Dinosaur.new(resultant.result_dinosaurs).names
      ap Dinosaur.new(resultant.result_dinosaurs).to_json

    end
  end

  def sanitize_user_input(value, characteristic)
    value = value.split(",") if value.include?(",")
    value = value.to_i       if characteristic == 5
    value
  end
end

DinoCatalog.new.run
