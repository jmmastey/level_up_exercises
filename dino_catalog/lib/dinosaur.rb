class Dinosaur

  BIG_DINOSAUR_LBS = 2
  POUNDS_PER_TON = 2000.0

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
    weight_in_tons > BIG_DINOSAUR_LBS
  end

  def small?
    weight_in_tons > 0 && weight_in_tons <= BIG_DINOSAUR_LBS
  end

  def weight_in_tons
    @weight_in_lbs.to_i / POUNDS_PER_TON
  end

  def to_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@")] = instance_variable_get(var) }
    hash
  end

end
