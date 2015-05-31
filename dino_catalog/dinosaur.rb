# Dinosaur provides the filter functionality
class Dinosaur
  SIZE_VALUE = 4000
  attr_accessor :name
  attr_accessor :period
  attr_accessor :continent
  attr_accessor :diet
  attr_accessor :weight
  attr_accessor :walking
  attr_accessor :description

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
    send('walking') == 'Biped'
  end

  def late_cretaceous?
    send('period') == 'Late Cretaceous'
  end

  def early_cretaceous?
    send('period') == 'Early Cretaceous'
  end

  def jurassic?
    send('period') == 'Jurassic'
  end

  def abrictosaurus?
    send('name') == 'Abrictosaurus'
  end

  def albertosaurus?
    send('name') == 'Albertosaurus'
  end

  def carnivore?
    value = %w(Carnivore Insectivore Piscivore)
    value.include? send('diet')
  end

  def big?
    @weight && @weight.to_i > SIZE_VALUE
  end

  def small?
    @weight && @weight.to_i < SIZE_VALUE
  end
end
