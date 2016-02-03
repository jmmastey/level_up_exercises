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
    listing = CSV.open(csv_file, :converters => :all,
                          :headers => true, :header_converters => :symbol)

    if csv_file.to_s.split("_").include? "african"
      add_dinos(african_dinos(listing))
    else
      add_dinos(dinos(listing))
    end
  end

  def add_dinos(dinos)
    @dino_dex.concat dinos
  end

  def dinos(listing)
    listing.map do |dino|
      Dino.new(dino[:name], dino[:period], dino[:continent],
               dino[:diet], dino[:weight_in_lbs],
               dino[:walking], dino[:description])
    end
  end

  def african_dinos(listing)
    listing.map do |dino|
      AfricanDino.new(dino[:genus], dino[:period], dino[:carnivore],
                      dino[:weight], dino[:walking])
    end
  end
  
  def dino_search(options={})
    dino_results = []
      options.each {|option,query| dino_results.concat send(option, query)}
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

  def diet_search(diet)
    if diet.eql? "Carnivore"
      carnivores
    elsif diet.eql? "Herbivore"
      herbivores
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
