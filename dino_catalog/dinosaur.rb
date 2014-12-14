require "json"

class Dinosaur
  SMALL_WEIGHT = 500
  BIG_WEIGHT = 4000

  attr_accessor :name, :period, :diet, :weight,
    :walking, :description, :continent

  def initialize(attributes)
    @name = attributes[:name]
    @period = attributes[:period]
    @diet = attributes[:diet]
    @weight = attributes[:weight]
    @walking = attributes[:walking]
    @description = attributes[:description]
    @continent = attributes[:continent]
  end

  def carnivore?
    %w(insectivore piscivore carnivore).include? diet.downcase
  end

  def small?
    weight > 0 && weight < SMALL_WEIGHT
  end

  def big?
    weight > BIG_WEIGHT
  end

  def period_within?(full_period)
    period.sub(/^(Early|Late)\s+/, "") == full_period
  end

  def to_h
    { name: name, period: period, diet: diet, weight: weight, walking: walking,
      description: description, continent: continent }
  end

  def to_json(*)
    to_h.to_json
  end
end
