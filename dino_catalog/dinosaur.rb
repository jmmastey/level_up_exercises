require 'colorize'

class Dinosaur
  @@fields = %w[name period continent diet weight walking description]
  attr_accessor :name, :period, :continent, :diet, :weight, :walking, :description

  def initialize()
    @name        = "Unknown-Name"
    @period      = "Unknown-Period"
    @continent   = "Unknown-Continent"
    @diet        = "Unknown-Diet"
    @weight      = "Unknown-Weight"
    @walking     = "Unknown-Walking"
    @description = "Unknown-Description"
  end

  def is_number?(object)
    true if Float(object) rescue false
  end

  def is_biped?
    @walking == "Biped"
  end

  def is_carnivore?
    ["Insectivore", "Carnivore", "Piscivore"].include?(@diet)
  end

  def is_heavy?
    is_number?(weight) && weight.to_i >= 4000    
  end

  def to_h
    result = {}
    result["name"]        = @name
    result["period"]      = @period
    result["continent"]   = @continent
    result["diet"]        = @diet
    result["weight"]      = @weight
    result["walking"]     = @walking
    result["description"] = @description
    result
  end

  def to_s
    result = @name.white + "\n"
    result += ("-" * @name.length).white + "\n"
    result += sprintf("  %-11s => %s\n", "Period",      @period)
    result += sprintf("  %-11s => %s\n", "Continent",   @continent)
    result += sprintf("  %-11s => %s\n", "Diet",        @diet)
    result += sprintf("  %-11s => %s\n", "Weight",      @weight)
    result += sprintf("  %-11s => %s\n", "Walking",     @walking)
    result += sprintf("  %-11s => %s\n", "Description", @description)
  end

  def matches?(criteria)
    attributes = to_h

    criteria.each do |criterion|
      key   = criterion[0]
      value = criterion[1]
      return false if !attributes.has_key?(key) || attributes[key] != value
    end
    
    true
  end

  def self.get_fields
    @@fields
  end
end
