# Dinosaur provides the filter functionality
class Dinosaur
  SIZE_VALUE = 4000
  attr_reader :name
  attr_reader :period
  attr_reader :continent
  attr_reader :diet
  attr_reader :weight
  attr_reader :walking
  attr_reader :description

  def initialize(attributes)
    @name  = attributes['name']
    @period  = attributes['period']
    @continent = attributes['continent']
    @diet = attributes['diet']
    @weight = attributes['weight_in_lbs']
    @walking = attributes['walking']
    @description = attributes['description']
  end

  def biped?
    @walking == 'Biped'
  end

  def late_cretaceous?
    @period == 'Late Cretaceous'
  end

  def early_cretaceous?
    @period == 'Early Cretaceous'
  end

  def jurassic?
    @period == 'Jurassic'
  end

  def abrictosaurus?
    @name == 'Abrictosaurus'
  end

  def albertosaurus?
    @name == 'Albertosaurus'
  end

  def carnivore?
    value = %w(Carnivore Insectivore Piscivore)
    value.include? @diet
  end

  def big?
    @weight && @weight.to_i > SIZE_VALUE
  end

  def small?
    @weight && @weight.to_i < SIZE_VALUE
  end
end
