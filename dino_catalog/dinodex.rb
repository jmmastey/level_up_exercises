require './dinoparse'

class DinoDex
  attr_accessor :dinos

  def initialize(files)
    @dinos = DinoParse.new(files)
  end

  def bipeds
    dinos.select { |dino| dino.walking.downcase == "biped"}
  end

  def carnivores
    dinos.select { |dino| dino.carnivore.downcase == "yes"}
  end

  def big
    dinos.select { |dino| dino.weight.to_i > 4000 }
  end

  def period(search)
    dinos.select { |dino| dino.period.map{ |a| a[:period].downcase == search.downcase}.reduce { |a, b| a || b} }
  end

  def cretaceous
    period("cretaceous")
  end

  def permian
    period("permian")
  end

  def jurassic
    period("jurassic")
  end

  def oxfordian
    period("oxfordian")
  end

  def albian
    period("albian")
  end

  def triassic
    period("triassic")
  end

  def filter(*filters)
    individual_results = []
    filters.each do |filter|
      individual_results << self.send(filter)
    end
    individual_results.reduce(&:&)
  end
end
