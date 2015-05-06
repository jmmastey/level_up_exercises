require './dino_class.rb'
class DinoDex
  def initialize(dino_arry)
    @dino_array = dino_arry
  end

  def run_user_interface
    @filter_query = { name: "", period: "", continent: "", diet: "", weight: "", walking: "" }
    @filter_query.each { |k, v| prompt_user_for_filter(k) }
    p @filter_query
    p filter_dinos(@filter_query)
  end

  def prompt_user_for_filter(filter_name)
    puts "Would you like to view dinosaurs by #{filter_name}? Y/N"
    values = Array.[]
    if gets.chomp.downcase == 'y'
      puts "Choose the number of the #{filter_name} you wish to view:"
      get_all_values(filter_name).each_with_index do |val, i|
        puts "#{i + 1}. #{val}\n"
        values << val
      end
      @filter_query[filter_name.to_sym] = values[gets.chomp.to_i - 1]
    end
  end

  def filter_dinos(filter)
    matching_dinos = Array[]
    @dino_array.each do |i|
      if i.name.include?(filter[:name]) && i.period.include?(filter[:period]) && i.diet.include?(filter[:diet])
        matching_dinos << i.name
        puts "#{i.name} is a match"
      end
    end
    matching_dinos
  end

  def get_all_values(key)
    values = Array[]
    @dino_array.each do |i|
      values << i.send(key)
    end
    values.uniq
  end
end
