require 'csv'
require_relative './dino.rb'
require_relative './dino_filters.rb'
require_relative './data_reader.rb'

ERAS_IN_DATA = ["Cretaceous (Early and Late)", "Jurassic", "Oxfordian",\
                "Late Permian", "Triassic"]

class UserInput
  FILTERS = %w(bipeds carnivores era big_dinos small_dinos)

  attr_reader :bipeds
  attr_reader :carnivores
  attr_reader :era
  attr_reader :big_dinos
  attr_reader :small_dinos

  def query_user
    puts "Do you want to ..."
    puts "filter for bipeds? (Y/N)?"
    self.bipeds = gets.chomp

    puts "filter for carnivores? (Y/N)?"
    self.carnivores = gets.chomp

    puts "filter for a specific era (enter name of era or leave blank)?"
    puts "Press 1 to print options."
    self.era = gets.chomp

    puts "filter for big dinos (enter the min weight cutoff or leave blank)?"
    self.big_dinos = gets.chomp

    puts "filter for small dinos (enter the max weight cutoff or leave blank)?"
    self.small_dinos = gets.chomp
  end

  def bipeds=(value)
    @bipeds = true if value =~ /^Y/i # otherise nil
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

  def perform_user_query(dino_filters)
    FILTERS.each do |var|
      var_info = instance_variable_get("@#{var}")
      dino_filters = select_filter(var, var_info, dino_filters) if var_info
    end
    dino_filters.summarize_list
  end

  def select_filter(var, var_info, dino_filters)
    return dino_filters.find_bipeds if var == "bipeds"
    return dino_filters.find_carnivores if var == "carnivores"
    return dino_filters.find_big_dinos(var_info) if var == "big_dinos"
    return dino_filters.find_small_dinos(var_info) if var == "small_dinos"
    return dino_filters.find_dinos_specific_era(var_info) if var == "era"
    raise "There was a problem."
  end
end
