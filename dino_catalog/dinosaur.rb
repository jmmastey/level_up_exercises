class Dinosaur
  attr_reader :name
  attr_accessor :period, :diet, :weight, :walking, :continent, :description

  WEIGHT_LIMIT = 2.0

  def initialize(name)
    @name = name
  end

  def carnivore?
    %w{Insectivore Carnivore Piscivore}.include?(diet)
  end

  def weight_in_tons
    weight.nil? ? nil : (weight.to_f / 2000)
  end

  def big?
    weight_in_tons > WEIGHT_LIMIT unless weight_in_tons.nil?
  end

  def small?
    weight_in_tons <= WEIGHT_LIMIT unless weight_in_tons.nil?
  end

  def to_h
    { name: name, period: period, diet: diet, weight: weight, walking: walking,
      continent: continent, description: description }
  end
end
