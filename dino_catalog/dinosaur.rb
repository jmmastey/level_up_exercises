class Dinosaur
  attr_accessor :name, :period, :diet, :weight,
    :walking, :description, :continent

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
    %w(insectivore piscivore carnivore).include? diet.downcase
  end
end
