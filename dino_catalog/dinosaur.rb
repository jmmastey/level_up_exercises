# Domain object that describes a dinosaur
class Dinosaur
  attr_reader :name, :period, :continent, :diet, :weight, :walking, :description

  def initialize(dino_entry)
    @name = dino_entry[:name]
    @period = dino_entry[:period]
    @continent = dino_entry[:continent]
    @diet = dino_entry[:diet]
    @weight = dino_entry[:weight].to_i
    @walking = dino_entry[:walking]
    @description = dino_entry[:description]
  end

  def big?
    @weight > 4000
  end

  def small?
    @weight <= 4000
  end

  def to_long_s
    "#{@name} lived during the #{@period} period in #{@continent}." \
      "It was a #{@diet} and it weighed in at over #{@weight} pounds." \
      "It was also a #{@walking}. #{@description}"
  end

  def to_s
    "#{@name}"
  end

  def to_json(*args)
    {
      name: @name,
      period: @period,
      continent: @continent,
      diet: @diet,
      weight: @weight,
      walking: @walking,
      description: @description
    }.to_json(*args)
  end
end
