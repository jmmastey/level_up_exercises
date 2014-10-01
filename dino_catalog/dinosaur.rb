# Class Dinosaur contains the structure of a dinosaur
class Dinosaur
  # attr methods
  attr_accessor :name, :period, :continent, :diet,
                :carnivore, :weight, :walking, :description

  def initialize(details = {})
    @name = details[:name]
    @period = details[:period]
    @continent = details[:continent]
    @diet = details[:diet]
    @weight = details[:weight]
    @walking = details[:walking]
    @description = details[:description]
  end

  def to_s
    to_hash.map do |(key, value)|
      "#{key.upcase}: #{value}".join(' | ') if value
    end
  end

  def to_hash
    {
      name: @name,
      period: @period,
      continent: @continent,
      diet: @diet,
      weight: @weight,
      walking: @walking,
      description: @description
    }
  end

  def to_json(*args)
    to_hash.to_json(*args)
  end
end
