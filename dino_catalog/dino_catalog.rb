require 'csv'
require 'pry'
require_relative 'dino'
require_relative 'african_dino'

class DinoCatalog
  
  attr_accessor :dino_dex

  def initialize
    @dino_dex = [] 
    @dino_results = []
  end

  def parse(csv_file)
    dino_array = CSV.open(csv_file, :converters => :all,
                          :headers => true, :header_converters => :symbol)

    if csv_file.to_s.split("_").include? "african"
      add_african_dinos(dino_array)
    else
      add_dinos(dino_array)
    end
  end

  def add_dinos(dino_array)
    dino_array.each do |dino|
      @dino_dex << Dino.new(dino[:name], dino[:period], dino[:continent],
                              dino[:diet], dino[:weight_in_lbs],
                              dino[:walking], dino[:description])
    end
  end

  def add_african_dinos(dino_array)
    dino_array.each do |dino|
      @dino_dex << AfricanDino.new(dino[:genus], dino[:period],
                                   dino[:carnivore], dino[:weight],
                                   dino[:walking])
    end
  end
  
  def dino_search(*options)
    dino_results = []
    options.each do |option|
      if option.is_a? Symbol
        dino_results.concat send(option)
      else
        option.each {|k,v| dino_results.concat send(k, v)}
      end
    end
    dino_results.uniq!.each {|dino| puts "----------"; dino_facts(dino)}
  end

  def name_search(*dino_names)
    @dino_dex.select { |dino| dino_names.include? dino.name}
  end

  def walking_search(*walk_styles)
    @dino_dex.select { |dino| walk_styles.include? dino.walking }
  end

  def period_search(*periods)
    @dino_dex.select do |dino| 
      dino.period.split.any? { |period| periods.include? period }
    end
  end

  def big_dinos
    @dino_dex.select do |dino|
      dino.weight_in_lbs > 4000 if dino.weight_in_lbs
    end
  end

  def small_dinos
    @dino_dex.select do |dino|
      dino.weight_in_lbs < 4000 if dino.weight_in_lbs
    end
  end

  def carnivores
    @dino_dex.select do |dino|
      ["Carnivore","Insectivore","Piscivore", "Yes"].include? dino.diet
    end
  end
  
  def herbivores
    @dino_dex.select { |dino| dino.diet == "Herbivore" }
  end
  
  def dino_facts(dino)
    dino.to_h.each do |heading, fact|
      puts "#{heading.capitalize}: #{fact}" unless fact.to_s.empty?
    end
  end
end
