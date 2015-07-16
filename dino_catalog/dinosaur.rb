class Dinosaur
  attr_accessor :name, :period, :continent, :diet, :weight, :walking, :desc

  def initialize(args = {})
     @name = args[:name]
     @period = args[:period]
     @continent = args[:continent]
     @diet = args[:diet]
     @weight = args[:weight]
     @walking = args[:walking]
     @desc = args[:desc]
  end

  def validate_input(args)
    args[:name]
    args[:period]
    args[:continent]
    args[:diet]
    args[:weight]
    args[:walking]
    args[:desc]
  end

  def validate_name(name)
  end

  def validate_period(period)
  end

  def validate_continent(continent)
  end

  def validate_diet(diet)
  end

  def validate_weight(weight)
  end

  def validate_walking(walking)
  end

  def validate_desc(desc)
  end
end
