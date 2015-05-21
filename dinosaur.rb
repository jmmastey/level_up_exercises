# Dinosaure provides the filter functionality
class Dinosaur
  SIZE_VALUE = 4000
  def initialize(attributes)
    @data = {}
    @data[:name]  = attributes['name']
    @data[:period] = attributes['period']
    @data[:continent] = attributes['continent']
    @data[:diet] = attributes['diet']
    @data[:weight] = attributes['weight_in_lbs']
    @data[:walking] = attributes['walking']
    @data[:description] = attributes['description']
  end

  def simple_filter?(attrb, value)
    @data[attrb] == value
  end

  def carnivore?(attrb, value)
    value.include? @data[attrb]
  end

  def big?
    @data[:weight] && @data[:weight].to_i > SIZE_VALUE
  end

  def small?
    @data[:weight] && @data[:weight].to_i < SIZE_VALUE
  end
end
