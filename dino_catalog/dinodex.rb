require './dinoparse'

class DinoDex
  attr_accessor :dinos

  def self.new_from_files(files)
    dinos = DinoParse.new(files)
    DinoDex.new(dinos)
  end

  def initialize(dinos)
    @dinos = dinos
  end

  def bipeds
    DinoDex.new(dinos.select { |dino| dino.walking.downcase == "biped"})
  end

  def carnivores
    DinoDex.new(dinos.select { |dino| dino.carnivore.downcase == "yes"})
  end

  def big
    DinoDex.new(dinos.select { |dino| dino.weight.to_i > 4000 })
  end

  def period(search)
    DinoDex.new(dinos.select { |dino| dino.period.map{ |a| a[:period].downcase == search.downcase}.reduce { |a, b| a || b} })
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
    DinoDex.new(individual_results.map{|dex| dex.dinos}.reduce(&:&))
  end

  def to_s
    dinos.each_with_index do |dino, index|
      puts "" unless index == 0
      puts dino
    end
  end
end
