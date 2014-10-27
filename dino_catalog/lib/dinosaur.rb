class Dinosaur

  attr_reader :name, :period, :continent, :diet, :weight_in_lbs, :walking, :description

  def initialize(name, options = {})
    @name = name
    @period = options[:period]
    @continent = options[:continent]
    @diet = options[:diet]
    @weight_in_lbs = options[:weight_in_lbs]
    @walking = options[:walking]
    @description = options[:description]
  end

  def big?
    weight_in_tons > 2
  end

  def small?
    weight_in_tons > 0 && weight_in_tons <= 2
  end

  def weight_in_tons
    @weight_in_lbs.to_i / 2000.0
  end

end
