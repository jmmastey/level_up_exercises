class Dinosaur
  attr_accessor :name
  attr_accessor :period
  attr_accessor :continent
  attr_accessor :diet
  attr_accessor :weight_in_lbs
  attr_accessor :walking
  attr_accessor :description

  def initialize(options = {})
    @name = options["NAME"]
    @period = options["PERIOD"]
    @continent = options["CONTINENT"]
    @diet = options["DIET"]
    @weight_in_lbs = options["WEIGHT_IN_LBS"]
    @walking = options["WALKING"]
    @description = options["DESCRIPTION"]
  end
end
