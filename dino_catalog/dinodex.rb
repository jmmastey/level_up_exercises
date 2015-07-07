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
    DinoDex.new(dinos.select { |dino| dino.walking.downcase == "biped" })
  end

  def carnivores
    DinoDex.new(dinos.select { |dino| dino.carnivore.downcase == "yes" })
  end

  def big
    DinoDex.new(dinos.select { |dino| dino.weight.to_i > 4000 })
  end

  def periods(search)
    DinoDex.new(dino_period_search(search))
  end

  def cretaceous
    periods("cretaceous")
  end

  def permian
    periods("permian")
  end

  def jurassic
    periods("jurassic")
  end

  def oxfordian
    periods("oxfordian")
  end

  def albian
    periods("albian")
  end

  def triassic
    periods("triassic")
  end

  def filter(*filters)
    individual_results = []
    filters.each do |filter|
      individual_results << send(filter)
    end
    DinoDex.new(individual_results.map(&:dinos).inject(&:&))
  end

  def to_s
    dinos.each_with_index do |dino, index|
      puts "" unless index == 0
      puts dino
    end
  end

  private

  def dino_period_search(search)
    dinos.select do |dino|
      matches = dino_periods_to_match_list(dino, search)
      matches.inject { |a, b| a || b }
    end
  end

  def dino_periods_to_match_list(dino, search)
    dino.periods.map do |period|
      period[:period].downcase == search.downcase
    end
  end
end
