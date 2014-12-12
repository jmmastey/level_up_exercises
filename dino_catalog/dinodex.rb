require_relative "dinosaur"
require_relative "dinoloader"

class DinoDex
  attr_reader :dinos

  include Enumerable

  def initialize(dinos)
    @dinos = dinos
  end

  def each
    @dinos.each {|dino| yield dino}
  end

  def filter_by_walking(walking)
    select {|dino| dino.walking == walking}
  end

  def filter_by_walking!(walking)
    @dinos = filter_by_walking(walking)
    self
  end

  def filter_by_diet(diet)
    diets = [diet]
    diets += ["Insectivore", "Piscivore"] if diet == "Carnivore"
    select {|dino| diets.include? dino.diet}
  end

  def filter_by_diet!(diet)
    @dinos = filter_by_diet(diet)
    self
  end

  def filter_by_period(period)
    select do |dino|
      clean_period = dino.period.sub(/^(Early|Late)\s+/, "")
      clean_period == period
    end
  end

  def filter_by_period!(period)
    @dinos = filter_by_period(period)
    self
  end

  def filter_big
    select {|dino| dino.weight > 4000}
  end

  def filter_big!
    @dinos = filter_big
    self
  end

  def filter_small
    select {|dino| dino.weight > 0 && dino.weight < 500}
  end

  def filter_small!
    @dinos = filter_small
    self
  end

  def print_all
    each {|dino| puts dino.to_s}
  end

end

dinos = DinoLoader.load("dinodex.csv") + DinoLoader.load("african_dinosaur_export.csv")

dinodex = DinoDex.new(dinos)
dinodex.filter_by_walking! "Biped"
puts "Bipeds"
dinodex.print_all

dinodex = DinoDex.new(dinos)
dinodex.filter_by_diet! "Carnivore"
puts "Carnivores"
dinodex.print_all

dinodex = DinoDex.new(dinos)
dinodex.filter_by_period! "Cretaceous"
puts "Cretaceous Period"
dinodex.print_all

dinodex = DinoDex.new(dinos)
dinodex.filter_big!
puts "Big"
dinodex.print_all

dinodex = DinoDex.new(dinos)
dinodex.filter_small!
puts "Small"
dinodex.print_all

dinodex = DinoDex.new(dinos)
dinodex.filter_by_walking!("Biped").filter_by_diet!("Carnivore").filter_small!
puts "Small Bipedal Carnivores"
dinodex.print_all
