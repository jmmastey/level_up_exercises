class Dino

  attr_reader :name, :period, :continent, :diet, :carnivore, :weight, :walking, :description

  def initialize(name, options = {})
    @name = name
    @period = options[:period]
    @continent = options[:continent]
    @diet = options[:diet]
    @carnivore = options[:carnivore]
    @weight = options[:weight].to_f
    @walking = options[:walking]
    @description = options[:description]
  end

  def to_s
    output = "Dino #{name}"
    output += " - Continent: #{continent}" if continent
    output += " - Period: #{period}" if period
    output += " - Diet: #{diet}" if diet
    output += " - Carnivore: #{carnivore}"
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
      :carnivore => carnivore,
      :diet => diet,
      :weight => weight,
      :walking => walking,
    }
  end
end
