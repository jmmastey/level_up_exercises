class Dino
  attr_accessor :name, :period, :continent, :diet, :weight_in_lbs,
                :walking, :description

  def initialize(name, period, continent, diet, weight, walking, description)
    @name = name
    @period = period
    @continent = continent
    @diet = diet
    @weight_in_lbs = weight
    @walking = walking
    @description = description
  end

  def to_h
    instance_variables.each_with_object({}) do |fact, hash|
      hash[fact.to_s.delete("@").to_sym] = instance_variable_get(fact)
    end
  end
end
