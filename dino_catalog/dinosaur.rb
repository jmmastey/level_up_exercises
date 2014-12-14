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
end
