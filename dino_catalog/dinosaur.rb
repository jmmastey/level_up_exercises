class Dinosaur
  attr_accessor :name
  attr_accessor :period
  attr_accessor :continent
  attr_accessor :diet
  attr_accessor :weight
  attr_accessor :walking
  attr_accessor :description

  def initialize(name: 'Trollosaurus Rex',
                 period: 'Late MSNerius',
                 continent: 'North America',
                 diet: 'People\'s Anger',
                 weight: '200',
                 walking: 'rarely',
                 description: 'Furry, lives in forests and comments online')
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
