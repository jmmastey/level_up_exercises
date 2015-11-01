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
    # true if this or that
  end

end
