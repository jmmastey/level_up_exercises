class Dinosaur
  #TODO accessors on one line, commas
  attr_accessor :name, :period, :diet, :weight, :walking, :continent, :description

  def to_s
    <<-displayblock
Name:\t\t#{name.to_s}
Period:\t\t#{period.to_s}
Diet:\t\t#{diet.to_s}
Weight:\t\t#{weight.to_s}
Walking:\t#{walking.to_s}
Continent:\t#{continent.to_s}
Description:\t#{description.to_s}
    displayblock
  end
end