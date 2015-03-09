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
    puts "Name: #{@name}" unless name.nil?
    puts "Period: #{@period}" unless period.nil?
    puts "Continent: #{@continent}" unless continent.nil?
    puts "Diet: #{@diet}" unless diet.nil?
    puts "Weight: #{@weight}" unless weight.nil?
    puts "Walking: #{@walking}" unless walking.nil?
    puts "Description: #{@description}" unless description.nil?
    puts ''
  end
end

