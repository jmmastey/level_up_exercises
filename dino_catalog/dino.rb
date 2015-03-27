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

  def like?(field, value) # I suppose I could avoid explict cases for each field...
    case field 
    when "NAME"
      return true if @name.include? value
    when "PERIOD"
      return true if @period.include? value
    when "CONTINENT"
      return true if @continent.include? value
    when "DIET"
      return true if @diet.include? value
    when "WEIGHT_IN_LBS" # ...I guess if you really want to string match on a number, sure.
      return true if @weight_in_lbs.include? value
    when "WALKING"
      return true if @walking.include? value
    when "DESCRIPTION"
      return true if @description.include? value
    end
    return false
  end

  def heavier_than?(pounds)
    return false if @weight_in_lbs.nil? # in case they send a negative number that would succeed against nil.to_i (zero)
    return @weight_in_lbs.to_i > pounds.to_i ? true : false 
  end

  def lighter_than?(pounds)
    return false if @weight_in_lbs.nil? # again, because nil.to_i == 0
    return @weight_in_lbs.to_i < pounds.to_i ? true : false 
  end

end

