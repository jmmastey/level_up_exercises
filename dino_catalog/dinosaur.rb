class Dinosaur
  attr_reader :name
  attr_accessor :period
  attr_accessor :diet
  attr_accessor :weight
  attr_accessor :walking
  attr_accessor :continent
  attr_accessor :description

  def initialize(name)
    @name = name
  end

  def carnivore?
    diet == 'Insectivore' || diet == 'Carnivore'
  end

  def weight_in_tons
    weight.nil? ? nil : (weight.to_f / 2000)
  end

  def facts_hash
    { name: name, period: period, diet: diet, weight: weight, walking: walking,
      continent: continent,description: description}
  end


end
