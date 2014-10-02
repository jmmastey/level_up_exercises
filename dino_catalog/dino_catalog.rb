#!/usr/bin/ruby

abort("foo")

# A mixin whereby a class can select one instance from a predefined list that corresponds with
# some input token; and an instance can be queried for its correspondence to input tokens.
# Used to implement keywords from the data files that translate to dinosaur attributes.
module TokenDecoder

  # isValidToken?
  #
  # Parameters
  #   prefix (string) - word to test as potential prefix of standard
  #   standard (string) - word to test whether prefix is leading match of
  # Returns: True iff "prefix" is a proper prefix of "standard" of more than 3 chars
  # Implements very simple method to equate input tokens to those recognized as identifying
  # objects descriptive of dinosaurs during input source interpretation
  def isValidToken?(prefix)

    (prefix.length >= 3) && (getStandard().slice(0, prefix.length).casecmp(prefix) == 0)
  end

  # getStandard (abstract)
  #
  # Returns: (string) A token that represents this object against which other tokens are matched
  # Must be overridden in comprising classes to provide a token to match
  def getStandard
    raise NotImplementedError
  end

  # createByToken (primary class interface method)
  #
  # Parameters
  #   token (string) - A token word to be used to select an instance of comprising class to create
  # Returns: (TokenFactory) An instance of the comprising class 
  # Called on comprising class to select an instance for the input token
  def self.createByToken(token)

    getStandardObjects.each do |instance|

      return instance if instance.isValidToken?(token)
    end

  # getStandardObjects (class, abstract)
  #
  # Returns: Predefined list of comprising class instances that may be selected by tokens
  def self.getStandardObjects
    raise NotImplementedError
  end
end  # module TokenDecoder


# DinoAmbulation
#
# Class handling and representing dinosaur locomotion (bi/quradrupedalism)
class DinoAmbulation
  include TokenDecoder

  attr_reader :ambulation     # (string) descriptive noun
end   # class DinoAmbulation


# DinoDiet
#
# Objects that represent the various specific types of diets that dinosaurs can have
class DinoDiet
  include TokenDecoder
  
  attr_reader :diet           # What such a diet is called (string)
  attr_reader :carnivorous    # Whether the diet is considered carnivorous (boolean)

  # Held private to fix list of legal diets
  private :new

  def initialize(diet, carnivorous = false)
    @diet = diet
    @carnivorous = carnivorous
  end

  @@diet_list = [
    @@INSECTIVORE = DinoDiet.new("insectivore", true),
    @@PISCIVORE = DinoDiet.new("piscivore", true),
    @@CARNIVORE = DinoDiet.new("carnivorous", true),
    @@UNSPECIFIED_CARNIVORE = DinoDiet.new("unspecified carnivore", true),
    @@UNSPECIFIED_NONCARNIVORE = DinoDiet.new("unspecified non-carnivore", false),
    @@UNKNOWN_DIET = DinoDiet.new("unknown diet", false)
  ]

  #
  # Implementing TokenDecoder interface
  #

  def self.getStandardObjects
    @@diet_list
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
