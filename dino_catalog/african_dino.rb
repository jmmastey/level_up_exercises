class AfricanDino < Dino
  attr_accessor :name, :period, :diet, :weight, :walking

  def initialize(name, period, diet, weight, walking)
    @name = name
    @period = period
    @diet = diet
    @weight_in_lbs = weight * 2.2 if weight

    @walking = walking
  end
end
