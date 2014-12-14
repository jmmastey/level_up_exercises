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
    @dinos = @dinos.select { |dino| dino.period_within?(period) }
    self
  end

  def filter_big
    @dinos = @dinos.select(&:big?)
    self
  end

  def filter_small
    @dinos = @dinos.select(&:small?)
    self
  end

  def display_all
    tp dinos, :name, :period, :diet, :weight,
      :walking, :continent, :description
  end

  def to_json
    @dinos.to_json
  end
end
