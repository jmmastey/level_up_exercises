class Dinosaur
  attr_accessor :genus, :weight, :walking, :continent, :description, :carnivore,
    :diet_details, :period
  def initialize(dinosaur)
    @genus = dinosaur[:genus]
    @weight = dinosaur[:weight]
    @walking = dinosaur[:walking]
    @continent = dinosaur[:continent]
    @description = dinosaur[:description]
    @diet_details = dinosaur[:diet_details]
    @carnivore = dinosaur[:carnivore]
    @period = dinosaur[:period]
  end
end
