class Dinosaur
  attr_accessor :name, :period, :diet, :weight, :walking, :continent,
    :description

  def initialize(dinosaur)
    @name = dinosaur["name"]
    @period = dinosaur["period"]
    @diet = dinosaur["diet"]
    @weight = dinosaur["weight_in_lbs"]
    @walking = dinosaur["walking"]
    @continent = dinosaur["continent"]
    @description = dinosaur["description"]
  end

  def to_s
    print_name
    print_period
    print_diet
    print_weight
    print_walking
    print_continent
    print_description
  end

  def print_name
    puts "Name:#{name}" if name
  end

  def print_period
    puts "Period:#{period}" if period
  end

  def print_diet
    puts "Diet:#{diet}" if diet
  end

  def print_weight
    puts "Weight:#{weight}" if weight
  end

  def print_walking
    puts "Walking:#{walking}" if walking
  end

  def print_continent
    puts "Continent:#{continent}" if continent
  end

  def print_description
    puts "Description:#{description}" if description
  end
end
