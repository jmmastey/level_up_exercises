require "table_print"
require_relative "dinosaur"
require_relative "dinoloader"

class DinoDex
  attr_reader :dinos

  def initialize(dinos)
    @dinos = dinos
  end

  def filter_by_walking(walking)
    @dinos = @dinos.select { |dino| dino.walking == walking }
    self
  end

  def filter_by_diet(diet)
    @dinos = @dinos.select { |dino| dino.diet == diet }
    self
  end

  def filter_carnivores
    @dinos = @dinos.select(&:carnivore?)
    self
  end

  def filter_by_period(period)
    @dinos = @dinos.select do |dino|
      clean_period = dino.period.sub(/^(Early|Late)\s+/, "")
      clean_period == period
    end
    self
  end

  def filter_big
    @dinos = @dinos.select { |dino| dino.weight > 4000 }
    self
  end

  def filter_small
    @dinos = @dinos.select { |dino| dino.weight > 0 && dino.weight < 500 }
    self
  end

  def display_all
    tp dinos, :name, :period, :diet, :weight,
      :walking, :continent, :description
  end
end
