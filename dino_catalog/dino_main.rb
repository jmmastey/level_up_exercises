require './dino_csv_import.rb'
require './dinodex_class.rb'

class UserInterface
  def initialize
    dino_input_files = ['./dinodex.csv', './african_dinosaur_export.csv']
    dinos = CsvImporter.new(dino_input_files).create_dinos
    @my_dinodex = DinoDex.new(dinos)
  end

  def run_user_interface
    @filter_query = { name: "", period: "", continent: "", diet: "", weight: 0, walking: "" }
    @filter_query.each_key { |k| prompt_user_for_inputs(k) }
    p @filter_query
    print_output(@my_dinodex.filter_dinos(@filter_query))
  end

  def prompt_user_for_inputs(filter_name)
    puts "Would you like to view dinosaurs by #{filter_name}? Y/N"
    if gets.chomp.downcase == 'y'
      puts "Choose the number of the #{filter_name} you wish to view:"
      user_choices =  print_values(filter_name)
      choice = gets.chomp.to_i - 1
      @filter_query[filter_name.to_sym] = user_choices[choice]
    end
  end

  def print_values(filter_name)
    values = Array[]
    @my_dinodex.get_all_values(filter_name).each_with_index do |val, i|
      puts "#{i + 1}. #{val}\n"
      values << val
    end
    values
  end

  def print_output(output_array)
    output_array.each do |i|
      puts "Match: #{i.all_info} \n"
    end
  end
end

UserInterface.new.run_user_interface
