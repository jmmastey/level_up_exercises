#!/usr/bin/ruby

require "token_decoder"

# DinoAmbulation
#
# Class handling and representing dinosaur locomotion (bi/quradrupedalism). Because this is a fixed
# list, it can be represented as such in software.
class DinoAmbulation
  include TokenDecoder

  attr_reader :ambulation     # (string) descriptive noun

  def initialize(ambulation_mode)
    @ambulation = ambulation_mode
  end

  # Enumerates all represented modes of ambulation and defines constants for each
  @@amb_list = [
      BIPEDAL       = new("bipedal"),
      QUADRUPEDAL   = new("quadrupedal"),
      UNKNOWN       = new("unknown")
  ]

  def self.getStandardObjects
    @@amb_list
  end

  def getStandard
    @ambulation
  end
end   # class DinoAmbulation


# DinoDiet
#
# Objects that represent the various specific types of diets that dinosaurs can have. Because is is
# in fact a fixed list, it can be represented as such in software.
class DinoDiet
  include TokenDecoder
  
  attr_reader :diet           # What such a diet is called (string)
  attr_reader :carnivorous    # Whether the diet is considered carnivorous (boolean)

  def initialize(diet_name, is_carnivore)
    @diet, @carnivorous = diet_name, is_carnivore
  end

  @@diet_list = [
    INSECTIVORE               = new("insectivore", true),
    PISCIVORE                 = new("piscivore", true),
    CARNIVORE                 = new("carnivorous", true),
    UNSPECIFIED_CARNIVORE     = new("unspecified carnivore", true),
    UNSPECIFIED_NONCARNIVORE  = new("unspecified non-carnivore", false),
    UNKNOWN_DIET              = new("unknown diet", false)
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


# TimePeriod
#
# Objects that represent a major interval in evolutionary/geological history. Because this is a fixed list
# it can be represented as such in software.
class TimePeriod
  include TokenDecoder

  attr_reader :formal_period
  attr_reader :sub_period

  def initialize(formal_period, sub_period = nil)
    @sub_period, @formal_period = sub_period, formal_period
  end

  # These terms are given meaning in the field of paleontology. Order counts as that determines how token 
  # matches are tested.
  @@period_list = [
    EARLY_OXFORDIAN   = new("Oxfordian", :early),
    LATE_OXFORDIAN    = new("Oxfordian", :late),
    OXFORDIAN         = new("Oxfordian"), 
    EARLY_PERMIAN     = new("Permian", :early),
    LATE_PERMIAN      = new("Permian", :late),
    PERMIAN           = new("Permian"),
    EARLY_ALBIAN      = new("Albian", :early),
    LATE_ALBIAN       = new("Albian", :late),
    ALBIAN            = new("Albian"),
    EARLY_TRIASSIC    = new("Triassic", :early),
    LATE_TRIASSIC     = new("Triassic", :late),
    TRIASSIC          = new("Triassic"),
    EARLY_JURASSIC    = new("Jurassic", :early),
    LATE_JURASSIC     = new("Jurassic", :late),
    JURASSIC          = new("Jurassic"),
    CRETACEOUS        = new("Cretaceous"), 
    EARLY_CRETACEOUS  = new("Cretaceous", :early), 
    LATE_CRETACEOUS   = new("Cretaceous", :late), 
    UNKOWN_PERIOD     = new("Unknown")
  ]

  def self.getStandardObjects
    @@period_list
  end

  def getStandard
    @standard_token ||= (@sub_period.nil? ? "" : (@sub_period.to_s + " ")) + @formal_period
  end
end 

class Dinosaur

  # initialize
  #
  # Parameters:
  #   taxon (string) - Defining clade
  #   period (TimePeriod)
  #   diet (DinoDiet)
  #   weight (integer)
  #   ambulation (DinoAmbulation)
  def initialize(taxon, period, diet, weight, ambulation, description = nil)

    @taxon, @period, @diet, @weight, @ambulation, @description =
      taxon, period, diet, weight, ambulation, description
  end
end

ARGV.each { |a|
  puts "a: #{TimePeriod.createByToken(a).inspect}\n"
}

