class Dino
  attr_accessor :name, :period, :continent, :diet, :weight, :walking, :description

  def initialize(name, period, continent, diet, weight, walking, description)
    @name = name
    @period = period
    @continent = continent
    @diet = diet
    @weight = weight
    @walking = walking
    @description = description
  end
end
