class Dino
  CARNIVORE = ["Carnivore", "Insectivore", "Piscivore"]
  HERBIVORE = ["Herbivore"]

  attr_reader :name, :period, :continent, :diet, :weight, :walking, :description

  def initialize(name, options = {})
    @name = name
    @period = options[:period]
    @continent = options[:continent]
    @diet = options[:diet]
    @weight = options[:weight]
    @walking = options[:walking]
    @description = options[:description]
  end

  def carnivore
    CARNIVORE.include? diet
  end

  def herbivore
    HERBIVORE.inlude? diet
  end

  def to_s
    output = "Dino #{name}"
    output += " - Continent: #{continent}" if continent
    output += " - Period: #{period}" if period
    output += " - Diet: #{diet}" if diet
    output += " - Weight: #{weight}" if weight
    output += " - Walking: #{walking}" if walking
    output += " - Description: #{description}" if description
    output
  end

  def to_hash
    {
      :name => name,
      :period => period,
      :continent => continent,
      :diet => diet,
      :weight => weight,
      :walking => walking,
    }
  end
end
