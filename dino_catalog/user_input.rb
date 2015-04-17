require 'csv'
require_relative './dino.rb'
require_relative './dino_filters.rb'
require_relative './data_reader.rb'

class UserInput
    
  def query_user
    puts "Do you want to filter for bipeds? (Y/N)?"
    @bipeds = gets.chomp

    puts "Do you want to filter for carnivores? (Y/N)?"
    @carnivores = gets.chomp

    puts "Do you want to filter for dinos from a specific era (enter name of era or leave blank)?"
    @era = gets.chomp

    puts "Do you want to filter for big dinos (enter the minimum weight cutoff)?"
    @big_dinos = gets.chomp

    puts "Do you want to filter for small dinos (enter the maximum weight cutoff)?"
    @small_dinos = gets.chomp
  end

  def process_user_input
    process_biped_input
    process_carnivore_input
    process_era_input
    process_bigdino_input
    process_smalldino_input
  end

  def process_biped_input
    if @bipeds =~ /^Y/i
      @bipeds = true
    else
      @bipeds = nil
    end
  end

  def process_carnivore_input
    if @carnivores =~ /^Y/i
      @carnivores = true
    else
      @carnivores = nil
    end
  end

  def process_era_input
    @era = nil unless @era =~ /^[A-Z]+/i
  end 

  def process_bigdino_input
    if @big_dinos.to_i > 0
      @big_dinos = @big_dinos.to_i
    else
      @big_dinos = nil
    end
  end

  def process_smalldino_input
    if @small_dinos.to_i > 0 
      @small_dinos = @small_dinos.to_i
    else
      @small_dinos = nil
    end
  end

  def build_user_query
    user_query = instance_variables.map do |var|
      var_info = instance_variable_get("#{var}")
      if var_info
        var = var.to_s.slice(1..-1)
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
    "There was a problem."
  end

end
