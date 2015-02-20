require 'json'

# dinasour object
class Dinosaur
  SMALL = 2000
  attr_accessor :name, :period, :diet, :weight,
                :walking, :description, :continent, :source

  def initialize(row)
    @name = row[:name]
    @period = row[:period]
    @diet = row[:diet]
    @weight = row[:weight]
    @walking = row[:walking]
    @description = row[:description]
    @continent = row[:continent]
    @source = row[:source]
  end

  def carnivore?
    %w(carnivore insectivore piscivore).include? diet.downcase
  end

  def small?
    weight > 0 && weight < SMALL
  end

  def big?
    weight > SMALL
  end

  def period_within?(fullperiod)
    period.sub(/^(Early|Late)\s+/, '') == fullperiod
  end

  def to_header
    {
      name: name, period: period, diet: diet, weight: weight,
      walking: walking, description: description,
      continent: continent, source: source
    }
  end

  def to_json(*)
    to_header.to_json
  end
end
