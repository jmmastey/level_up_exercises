#!/usr/bin/ruby

require "token_decoder"

# DinoAmbulation
#
# Class handling and representing dinosaur locomotion (bi/quradrupedalism)
class DinoAmbulation
  include TokenDecoder

  attr_reader :ambulation     # (string) descriptive noun

  @@amb_list = [
      BIPEDAL = Class.new(DinoAmbulation) { @ambulation = "bipedal"; }.new,
      QUADRUPEDAL = Class.new(DinoAmbulation) { @ambulation = "quradrupedal"; }.new
  ]

  def self.getStandardObjects
    @@amb_list
  end
end   # class DinoAmbulation


# DinoDiet
#
# Objects that represent the various specific types of diets that dinosaurs can have
class DinoDiet
  include TokenDecoder
  
  attr_reader :diet           # What such a diet is called (string)
  attr_reader :carnivorous    # Whether the diet is considered carnivorous (boolean)

  @@diet_list = [
    INSECTIVORE = (Class.new(DinoDiet) { @@diet = "insectivore"; @@carnivorous = true }).new,
    PISCIVORE = Class.new(DinoDiet) { @@diet, @@carnivorous = "piscivore", true }.new,
    CARNIVORE = Class.new(DinoDiet) { @@diet, @@carnivorous = "carnivorous", true }.new,
    UNSPECIFIED_CARNIVORE = Class.new(DinoDiet) { @@diet, @@carnivorous = "unspecified carnivore", true }.new,
    UNSPECIFIED_NONCARNIVORE = Class.new(DinoDiet) { @@diet, @@carnivorous = "unspecified non-carnivore", false }.new,
    UNKNOWN_DIET = Class.new(DinoDiet) { @@diet, @@carnivorous = "unknown diet", false }.new
  ]

  #
  # Implementing TokenDecoder interface
  #

  def self.getStandardObjects
    @@diet_list
  end

  def getStandard
    @@diet
  end
end   # class DinoDiet


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

ARGV.each { |a|
  puts "a: #{DinoDiet.createByToken(a).inspect}\n"
}

