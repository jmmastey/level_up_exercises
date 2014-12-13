require "table_print"
require_relative "dinosaur"
require_relative "dinoloader"

class DinoDex
  attr_reader :dinos

  include Enumerable

  def initialize(dinos)
    @dinos = dinos
  end

  def each
    @dinos.each { |dino| yield dino }
  end

  def filter_by_walking(walking)
    select { |dino| dino.walking == walking }
  end

  def filter_by_walking!(walking)
    @dinos = filter_by_walking(walking)
    self
  end

  def filter_by_diet(diet)
    select { |dino| dino.diet == diet }
  end

  def filter_by_diet!(diet)
    @dinos = filter_by_diet(diet)
    self
  end

  def filter_carnivores
    select(&:carnivore?)
  end

  def filter_carnivores!
    @dinos = filter_carnivores
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
    select { |dino| dino.weight > 4000 }
  end

  def filter_big!
    @dinos = filter_big
    self
  end

  def filter_small
    select { |dino| dino.weight > 0 && dino.weight < 500 }
  end

  def filter_small!
    @dinos = filter_small
    self
  end

  def display_all
    tp dinos, :name, :period, :diet, :weight,
      :walking, :continent, :description
  end
end
