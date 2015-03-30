class Dino
  attr_reader :name, :period, :continent, :diet, :weight_in_lbs, :walking, :description

  def initialize(attr_hash)
    @name = attr_hash["NAME"]
    @period = attr_hash["PERIOD"]
    @continent = attr_hash["CONTINENT"]
    @diet = attr_hash["DIET"]
    @weight_in_lbs = attr_hash["WEIGHT_IN_LBS"]
    @walking = attr_hash["WALKING"]
    @description = attr_hash["DESCRIPTION"]
  end

  def like?(field, value) 
    if self.respond_to? field.downcase
      (self.send field.downcase).include? value
    else
      false
    end
  end

  def heavier_than?(pounds)
    return false if @weight_in_lbs.nil? # in case they send a negative number that would succeed against nil.to_i (zero)
    @weight_in_lbs.to_i > pounds.to_i
  end

  def lighter_than?(pounds)
    return false if @weight_in_lbs.nil? # again, because nil.to_i == 0
    @weight_in_lbs.to_i < pounds.to_i
  end

end