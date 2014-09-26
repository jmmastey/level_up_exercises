require 'json'

class Dino
  attr_accessor :name, :period, :continent, :diet, :weight, :walking
  attr_accessor :description

  ATTRIBUTES = %w[name period continent diet weight walking description]

  def initialize(opts)
    @name = opts[:name]
    @period = opts[:period]
    @continent = opts[:continent]
    @diet = opts[:diet]
    @weight = opts[:weight]
    @walking = opts[:walking]
    @description = opts[:description]
  end

  def to_hash
    ATTRIBUTES.each_with_object({}) { |att, result| result[att] = send(att) }
  end

  def to_json
    to_hash.to_json
  end

  def to_s
    ATTRIBUTES.map { |att| attr_to_s(att) }.join(", ")
  end

  def small?
    @weight <= 2000
  end

  def big?
    !small?
  end

  def biped?
    @walking == "Biped"
  end

  def carnivore?
    %w[Carnivore Insectivore Piscivore].include? @diet
  end

  def lived_during?(period)
    @period.downcase.include? period
  end

  private

  def attr_to_s(attrib_name)
    attr_value = send(attrib_name)
    attr_value ? "#{attrib_name}: #{attr_value}" : ""
  end
end
