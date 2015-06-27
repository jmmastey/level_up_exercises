class Dinosaur
  attr_reader :name
  attr_accessor :period, :diet, :weight, :walking, :continent, :description

  def initialize(name)
    @name = name
  end

  def carnivore?
    diet == 'Insectivore' || diet == 'Carnivore'
  end

  def weight_in_tons
    weight.nil? ? nil : (weight.to_f / 2000)
  end

  WEIGHT_LIMIT = 2.0

  def big?
    !weight_in_tons.nil? && weight_in_tons > WEIGHT_LIMIT
  end

  def small?
    !weight_in_tons.nil? && weight_in_tons <= WEIGHT_LIMIT
  end

  def facts_hash
    { name: name, period: period, diet: diet, weight: weight, walking: walking,
      continent: continent, description: description }
  end
end
