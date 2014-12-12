class Dinosaur
  attr_accessor :name, :period, :diet, :weight, :walking, :description, :continent

  def initialize(attributes)
    @name = attributes[:name]
    @period = attributes[:period]
    @diet = attributes[:diet]
    @weight = attributes[:weight]
    @walking = attributes[:walking]
    @description = attributes[:description]
    @continent = attributes[:continent]
  end

  def carnivore?
    ["insectivore", "piscivore", "carnivore"].include? diet.downcase
  end

  def to_s
    string = "Name: #{name}"
    string += ", Description: #{description}" if description
    string += ", Period: #{period}" if period.length
    string += ", Diet: #{diet}" if diet.length
    string += ", Weight: #{weight} pounds" if weight.to_i > 0
    string += ", Walking: #{walking}" if walking
    string += ", Continent: #{continent}" if continent
    string
  end

end

