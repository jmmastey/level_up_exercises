# This class defines a dinosaur and its properties
class Dinosaur
  attr_accessor :name, :period, :continent, :weight, :diet,
                :walking, :description, :size
  WEIGHT_LIMIT = 4000

  def initialize(args = {})
    @name = args['name'] || args['genus']
    @period = args['period']
    @continent = args['continent'] || 'African'
    @weight = args['weight_in_lbs'] || args['weight']
    @diet = args['diet'] || fix_carnivore(args['carnivore'])
    @walking = args['walking']
    @description = args['description']
    @size = big? ? 'Big' : 'Small'
  end

  def fix_carnivore(carnivore)
    carnivore && carnivore == 'Yes' ? 'Carnivore' : 'Herbivore'
  end

  def big?
    @weight.to_i > WEIGHT_LIMIT
  end

  def biped?
    @walking.include?('biped')
  end

  def quadruped?
    @walking.include?('quadruped')
  end

  def period?(search_string)
    @period.include?(search_string)
  end

  def to_h
    {
      'Name' => @name,
      'Period' => @period,
      'Continet' => @continent,
      'Weight' => @weight,
      'Diet' => @diet,
      'Walking' => @walking,
      'Description' => @description,
      'Size' => @size
    }
  end
end
