require 'pry'
class Dinosaur
  @@carnivore_types = ['Carnivore', 'Insectivore', 'Piscivore']
  attr_accessor :name, :diet, :carnivore, :period, :weight,
	        :walking, :continent, :description

  def initialize(attrib)
    @name = (attrib[:name] || attrib[:genus])
    @diet = attrib[:diet]
    @carnivore = carnivore_check(attrib[:carnivore])
    @period_prefix, @period = period_check(attrib[:period])
    @weight = (attrib[:weight] || attrib[:weight_in_lbs])
    @walking = attrib[:walking]
    @continent = attrib[:continent]
    @description = attrib[:description]
  end

  def carnivore_check(d)
    return d if d
    return nil if !@diet
    @@carnivore_types.include?(@diet) ? 'Yes' : 'No'
  end

  def period_check(p)
    p_split = p.split(" ")

    if p_split.length > 1
      [p_split[0], p_split[1]]
    else
      [nil, p_split[0]]
    end
  end
end
