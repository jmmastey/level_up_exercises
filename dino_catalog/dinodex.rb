require "csv"

class Dinosaur
  attr_accessor :name, :period, :diet, :weight, :walking, :description, :continent

  def to_s
    string = "Name: #{name}"
    string += ", Description: #{description}" if description
    string += ", Period: #{period}" if period.length
    string += ", Diet: #{diet}" if diet.length
    string += ", Weight: #{weight} pounds" if weight.to_i > 0
    string += ", Walking: #{walking}" if walking
    string += ", Continent: #{continent}" if continent
    string
  end

end

class DinoDex
  attr_reader :dinos

  include Enumerable

  def initialize
    @dinos = []
    @dinos += load_index
    @dinos += load_african
  end

  def load_index
    csv = CSV.read("dinodex.csv", headers: :first_row)
    csv.map do |row|
      dino = Dinosaur.new
      dino.name = row["NAME"]
      dino.period = row["PERIOD"]
      dino.diet = row["DIET"]
      dino.weight = row["WEIGHT_IN_LBS"].to_i
      dino.walking = row["WALKING"]
      dino.description = row["DESCRIPTION"]
      dino.continent = row["CONTINENT"]
      dino
    end
  end

  def load_african
    csv = CSV.read("african_dinosaur_export.csv", headers: :first_row)
    csv.map do |row|
      dino = Dinosaur.new
      dino.name = row["Genus"]
      dino.period = row["Period"]
      dino.diet = row["Carnivore"] == "yes" ? "Carnivore" : ""
      dino.weight = row["Weight"].to_i
      dino.walking = row["Walking"]
      dino
    end
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

dinodex = DinoDex.new
dinodex.filter_by_walking! "Biped"
puts "Bipeds"
dinodex.print_all

dinodex = DinoDex.new
dinodex.filter_by_diet! "Carnivore"
puts "Carnivores"
dinodex.print_all

dinodex = DinoDex.new
dinodex.filter_by_period! "Cretaceous"
puts "Cretaceous Period"
dinodex.print_all

dinodex = DinoDex.new
dinodex.filter_big!
puts "Big"
dinodex.print_all

dinodex = DinoDex.new
dinodex.filter_small!
puts "Small"
dinodex.print_all

dinodex = DinoDex.new
dinodex.filter_by_walking!("Biped").filter_by_diet!("Carnivore").filter_small!
puts "Small Bipedal Carnivores"
dinodex.print_all
