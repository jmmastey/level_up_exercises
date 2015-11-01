class Dinosaur

  attr_accessor :name, :period, :continent, :diet, :weight_lbs, :walking, :description

  def initialize(opts={})
    @name = opts[:name]
    @period = opts[:period]
    @continent = opts[:continent]
    @diet = opts[:diet]
    @weight_lbs = opts[:weight_lbs]
    @walking = opts[:walking]
    @description = opts[:description]
  end

  def big?
    @weight_lbs > 2000
  end

  def carnivore?
    # Include fish and insects due to requirements
    ["Carnivore", "Insectivore", "Piscivore"].any? { |opt| @diet == opt}
  end

end
