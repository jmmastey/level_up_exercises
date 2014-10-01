#!/usr/bin/ruby

# DinoDiet
#
# Objects that represent the various specific types of diets that dinosaurs can have
class DinoDiet

  attr_reader :diet           # What such a diet is called (string)
  attr_reader :carnivorous    # Whether the diet is considered carnivorous (boolean)

  # classify (class method) 
  #
  # Parameters:
  #   diet_name (string) - the name of a diet
  # Returns:
  #   (DinoDiet) A DinoDiet that identifies best with the diet name
  # Translates a string bearing a diet name into a DinoDiet. (This factory may well belong in its own class
  # because, after all, this class couldn't anticipate every mapping nor all input data types...)
  def self.classify(diet_name)

    dname = diet_name.downcase

    @@diet_list.each do |diet_type|
      return diet_type if diet_type.is_legal_alias?(dname)
    end

    return @@UNKNOWN_DIET
  end


  # is_legal_alias?
  # 
  # Parameters:
  #   diet_name (string) - A string that may represent the name of a type of diet
  # Return value: true iff diet_name can represent this DietType; else false
  # Used privately to classify names of diets (as strings) as one of the declared diet types. A name
  # is a legal alias when it is at least a three-letter prefix of the DinoDiet independent of letter case
  def is_legal_alias?(diet_name)

    return (diet_name.length > 3) && (@diet.slice(0, diet_name.length) == diet_name)
  end
  protected :is_legal_alias?


  # Held private to fix list of legal diets
  def initialize(diet, carnivorous = false)
    @diet = diet
    @carnivorous = carnivorous
  end
  private :initialize

  @@diet_list = [
    @@INSECTIVORE = DinoDiet.new("Insectivore", true),
    @@PISCIVORE = DinoDiet.new("Piscivore", true),
    @@CARNIVORE = DinoDiet.new("Carnivorous", true),
    @@UNSPECIFIED_CARNIVORE = DinoDiet.new("Unspecified carnivore", true),
    @@UNSPECIFIED_NONCARNIVORE = DinoDiet.new("Unspecified non-carnivore", false),
    @@UNKNOWN_DIET = DinoDiet.new("Unknown diet", false)
  ]
end


class Dinosaur

  # initialize
  #
  # Parameters:
  #   taxon (string) - Defining clade
  #   period (symbol) - Interval of history
  #   diet (string) - 
  def initalize(taxon, period, diet, weight, ambulation, description = nil)

  end
end
