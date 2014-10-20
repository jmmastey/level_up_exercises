class Dinosaur

  attr_reader :name, :period, :continent, :diet, :weight_in_lbs, :walking, :description

  def initialize(attributes)
    @name = attributes[:name]
    @period = attributes[:period]
    @continent = attributes[:continent]
    @diet = attributes[:diet]
    @weight_in_lbs = attributes[:weight_in_lbs]
    @walking = attributes[:walking]
    @description = attributes[:description]
  end

end
