#!/usr/bin/ruby

require "token_decoder"

# DinoAmbulation
#
# Class handling and representing dinosaur locomotion (bi/quradrupedalism)
class DinoAmbulation
  include TokenDecoder

  attr_reader :ambulation     # (string) descriptive noun

  @amb_list = [
      BIPEDAL = Class.new(DinoAmbulation) { @ambulation = "bipedal"; }.new,
      QUADRUPEDAL = Class.new(DinoAmbulation) { @ambulation = "quradrupedal"; }.new
  ]

  def self.getStandardObjects
    @amb_list
  end
end   # class DinoAmbulation


# DinoDiet
#
# Objects that represent the various specific types of diets that dinosaurs can have
class DinoDiet
  include TokenDecoder
  
  attr_reader :diet           # What such a diet is called (string)
  attr_reader :carnivorous    # Whether the diet is considered carnivorous (boolean)

  def initialize(diet, carnivorous = false)
    @diet = diet
    @carnivorous = carnivorous
  end

  # Hold private so no more of these things can be created
  private_class_method :new

  #
  # Implementing TokenDecoder interface
  #

  def self.getStandardObjects
    [
      INSECTIVORE = DinoDiet.new("insectivore", true),
      PISCIVORE = DinoDiet.new("piscivore", true),
      CARNIVORE = DinoDiet.new("carnivorous", true),
      UNSPECIFIED_CARNIVORE = DinoDiet.new("unspecified carnivore", true),
      UNSPECIFIED_NONCARNIVORE = DinoDiet.new("unspecified non-carnivore", false),
      UNKNOWN_DIET = DinoDiet.new("unknown diet", false)
    ]
  end

  def getStandard
    @diet
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

