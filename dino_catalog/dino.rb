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
    when "name"
      return true if :name.include? value
    when "period"
      return true if :period.include? value
    when "continent"
      return true if :continent.include? value
    when "diet"
      return true if :diet.include? value
    when "weight_in_lbs"
      return true if :weight_in_lbs.include? value
    when "walking"
      return true if :walking.include? value
    when "description"
      return true if :description.include? value
    end
    return false
  end

  def heavier_than?(pounds)
    return @weight_in_lbs.to_i > pounds ? true : false 
  end

end

