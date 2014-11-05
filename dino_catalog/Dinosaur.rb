require 'pry'
class Dinosaur
  @@carnivore_types = ['Carnivore', 'Insectivore', 'Piscivore']
  attr_accessor :name, :diet, :carnivore, :period, :weight,
                :walking, :continent, :description

  def initialize(attrib)
    @name                   = (attrib[:name])
    @diet                   = attrib[:diet]
    @carnivore              = assign_carnivore(attrib[:carnivore])
    @period_prefix, @period = assign_period(attrib[:period])
    @weight                 = (attrib[:weight])
    @walking                = attrib[:walking]
    @continent              = attrib[:continent]
    @description            = attrib[:description]
  end

  def assign_carnivore(d)
    return d if d
    return nil if !@diet
    @@carnivore_types.include?(@diet) ? 'Yes' : 'No'
  end

  def assign_period(p)
    ps = p.split(" ")
    ps.length > 1 ? [ps[0], ps[1]] : [nil, ps[0]]
  end

  def to_h
    hash = {}
    instance_variables.each do |var| 
      hash[var.to_s.delete("@")] = instance_variable_get(var)
    end
    hash
  end
end
