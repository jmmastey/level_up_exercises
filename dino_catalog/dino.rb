class Dino
  attr_reader :name
  attr_reader :period
  attr_reader :continent
  attr_reader :diet
  attr_reader :weight
  attr_reader :walking
  attr_reader :description
  DINO_ATTRIBUTES = [:name, :period, :continent, :diet, :weight, :walking,
                     :description].freeze

  def initialize(attrs)
    @name = attrs[:name]
    @period = attrs[:period]
    @continent = attrs[:continent]
    @diet = attrs[:diet]
    @weight = attrs[:weight]
    @walking = attrs[:walking]
    @description = attrs[:description]
  end

  def carnivore_or_herbivore
    diet == "Herbivore" ? diet : "Carnivore"
  end

  def to_hash
    attribute_hash = {}
    DINO_ATTRIBUTES.each do |attribute|
      value = send(attribute)
      attribute_hash[attribute] = send(attribute) unless value.nil?
    end
    attribute_hash
  end
end
