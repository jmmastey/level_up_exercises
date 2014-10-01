#!/usr/bin/ruby

class DinoDiet

  attr_reader :diet           # What such a diet is called (string)
  attr_reader :carnivorous?   # Whether the diet is considered carnivorous (boolean)

  # Held private to fix list of legal diets
  def initialize(diet, carnivorous = false)
    @diet = diet
    @carnivorous? = carnivorous
  end

  @@INSECTIVORE = DinoDiet.new("Insectivore", true)
  @@PISCIVORE = DinoDiet.new("Piscivore", true)
  @@CARNIVORE = DinoDiet.new("Carnivorous", true)
  @@UNSPECIFIED_CARNIVORE = DinoDiet.new("Unspecified carnivore", true)
  @@UNSPECIFIED_NONCARNIVORE = DinoDiet.new("Unspecified non-carnivore", false)

  #
  # REREADING REQUIREMENTS: THIS APPROACH IS MORE INFORMATIVE THAN NECESSARY
  #
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
