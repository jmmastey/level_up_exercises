class Dinosaur
  attr_accessor :name
  attr_accessor :period
  attr_accessor :continent
  attr_accessor :diet
  attr_accessor :weight
  attr_accessor :walking
  attr_accessor :description

  def initialize(name,
                 period,
                 continent,
                 diet,
                 weight,
                 walking,
                 description)
    @name = name
    @period = period
    @continent = continent
    @diet = diet
    @weight = weight
    @walking = walking
    @description = description
  end

  def [](arg)
    send(arg)
  end
end
