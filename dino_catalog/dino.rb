class Dino
  attr_reader :name, :period, :continent, :diet, :weight, :walking, :description

  def initialize(args)
    @name = args[:name]
    @period = args[:period]
    @continent = args[:continent]
    @diet = args[:diet]
    @weight = args[:weight]
    @walking = args[:walking]
    @description = args[:description]
  end

  def print
    puts "Name: #{@name}" if name
    puts "Period: #{@period}" if period
    puts "Continent: #{@continent}" if continent
    puts "Diet: #{@diet}" if diet
    puts "Weight: #{@weight}" if weight
    puts "Walking: #{@walking}" if walking
    puts "Description: #{@description}" if description
    puts ''
  end
end
