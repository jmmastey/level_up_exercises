class Dinosaur
  attr_accessor :name
  attr_accessor :period
  attr_accessor :diet
  attr_accessor :weight
  attr_accessor :walking
  attr_accessor :continent
  attr_accessor :description

  def initialize()
    @name, @period, @diet, @weight, @walking, @continent, @description = ''
  end

  def to_s
    <<-displayblock
Name: #{name.to_s}
Period: #{period.to_s}
Diet: #{diet.to_s}
Weight: #{weight.to_s}
Walking: #{walking.to_s}
Continent: #{continent.to_s}
Description: #{description.to_s}
    displayblock
  end
end