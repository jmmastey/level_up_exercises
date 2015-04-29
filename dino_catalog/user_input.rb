require './dino_filters.rb'

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
    puts "Press 1 to print options. Type the option you want."
    self.era = gets.chomp

    puts "filter for big dinos (enter the min weight cutoff or leave blank)?"
    self.big_dinos = gets.chomp

    puts "filter for small dinos (enter the max weight cutoff or leave blank)?"
    self.small_dinos = gets.chomp
  end

  def bipeds=(input)
    @bipeds = true if input =~ /^Y/i # otherise nil
  end

  def carnivores=(input)
    @carnivores = true if input =~ /^Y/i
  end

  def era=(input)
    if input =~ /^[1]/
      ERAS_IN_DATA.each { |era_option| puts era_option }
      input = gets.chomp
    end
    @era = input if input =~ /^[A-Z]+/i
  end

  def big_dinos=(input)
    @big_dinos = input.to_i if input.to_i != 0
  end

  def small_dinos=(input)
    @small_dinos = input.to_i if input.to_i != 0
  end

  def perform_user_query(dino_filters)
    FILTERS.each do |filter|
      filter_val = instance_variable_get("@#{filter}")
      dino_filters = select_filter(filter, filter_val, dino_filters) if filter_val
    end
    dino_filters.summarize_list
  end

  def select_filter(var, var_info, dino_filters)
    return dino_filters.find_bipeds if var == "bipeds"
    return dino_filters.find_carnivores if var == "carnivores"
    return dino_filters.find_big_dinos(var_info) if var == "big_dinos"
    return dino_filters.find_small_dinos(var_info) if var == "small_dinos"
    return dino_filters.find_dinos_specific_era(var_info) if var == "era"
    raise "Error: the instance variable you want to filter on doesn't exist."
#   filter_options = {}
#   filter_options["bipeds"] = :find_bipeds
#   filter_options["carnivores"] = :find_carnivores
#   filter_options["big_dinos"] = :find_big_dinos
#   filter_options["small_dinos"] = :find_small_dinos
#   filter_options["era"] = :find_dinos_specific_era
#   dino_filters.send(filter_options[var], var_info)
  end
end
