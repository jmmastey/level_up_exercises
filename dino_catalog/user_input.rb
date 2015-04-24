require 'csv'
require_relative './dino.rb'
require_relative './dino_filters.rb'
require_relative './data_reader.rb'

ERAS_IN_DATA = ["Cretaceous (Early and Late)", "Jurassic", "Oxfordian", "Late Permian", "Triassic"] 

class UserInput
  FILTERS = %w(bipeds carnivores era big_dinos small_dinos)

  attr_reader :bipeds
  attr_reader :carnivores
  attr_reader :era
  attr_reader :big_dinos
  attr_reader :small_dinos

  def query_user
    puts "Do you want to filter for bipeds? (Y/N)?"
    self.bipeds = gets.chomp

    puts "Do you want to filter for carnivores? (Y/N)?"
    self.carnivores = gets.chomp

    puts "Do you want to filter for dinos from a specific era (enter name of era or leave blank)?"
    puts "Press 1 to print options."
    self.era = gets.chomp

    puts "Do you want to filter for big dinos (enter the minimum weight cutoff or leave blank)?"
    self.big_dinos = gets.chomp

    puts "Do you want to filter for small dinos (enter the maximum weight cutoff or leave blank)?"
    self.small_dinos = gets.chomp
  end

  def bipeds=(value)
    @bipeds = true if value =~ /^Y/i #otherise nil
  end
  
  def carnivores=(value)
    @carnivores = true if value =~ /^Y/i
  end

  def era=(value)
    if value =~ /^[1]/
      ERAS_IN_DATA.each { |option| puts option }
      value = gets.chomp
    end
    @era = value if value =~ /^[A-Z]+/i
  end 

  def big_dinos=(value)
    @big_dinos = value.to_i if value.to_i != 0
  end

  def small_dinos=(value)
    @small_dinos = value.to_i if value.to_i != 0
  end

  def build_user_query
    user_query = FILTERS.map do |var|
      var_info = instance_variable_get("@#{var}")
      if var_info
        format_query(var, var_info)
      end
    end
    user_query += ["summarize_list"]
    user_query = user_query.join
  end
    
  def format_query(var, var_info)
    return "find_bipeds." if var == "bipeds"
    return "find_carnivores." if var == "carnivores"
    return "find_big_dinos(#{var_info})." if var == "big_dinos"
    return "find_small_dinos(#{var_info})." if var == "small_dinos"
    return "find_dinos_specific_era('#{var_info}')." if var == "era"
    raise "There was a problem."
  end

end
