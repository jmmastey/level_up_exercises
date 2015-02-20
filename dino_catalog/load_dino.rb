require 'csv'
require_relative 'Dinosaur'

class DinoCollection
  
  attr_reader :dino_collection

  def initialize
  @dino_collection ||= {}
  end

  def african_dino_parser(name)
    CSV.foreach(name, converters: :numeric, headers:\
    true) do |dino|
      dinosaur = {}
      dinosaur[:name] = dino['Genus']
      dinosaur[:period] = split_period(dino['Period'])
      dinosaur[:diet] = convert_diet(dino['Carnivore'])
      dinosaur[:movement] = dino['Walking']
      dinosaur[:weight] = dino['Weight']
      dinosaur[:continent] = "Africa"
      @dino_collection[dino['Genus']] = Dinosaur.new(dinosaur)
    end
  end

  def normal_dino_parser(name)
    CSV.foreach(name, converters: :numeric, headers:\
    true) do |dino|
      dinosaur = {}
      dinosaur[:name] = dino['NAME']
      dinosaur[:period] = split_period(dino['PERIOD'])
      dinosaur[:diet] = dino['DIET']
      dinosaur[:movement] = dino['WALKING']
      dinosaur[:weight] = dino['WEIGHT_IN_LBS']
      dinosaur[:continent] = dino['CONTINENT']
      dinosaur[:description] = dino['DESCRIPTION']
      @dino_collection[dino['NAME']] =  Dinosaur.new(dinosaur)
    end
  end

  def split_period(period)
    periods ||= []
    if /(.+)\sor\s(.+)/.match(period)
      periods << Regexp.last_match(1)
      periods << split_period(Regexp.last_match(2))
    else
      periods << period
    end
  end
  
  def convert_diet(diet)
    if diet == 'Yes'
      "Carnivore"
    else
      "Herbivore"
    end
  end
  
end 

