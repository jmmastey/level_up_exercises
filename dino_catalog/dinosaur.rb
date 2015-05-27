class Dinosaur
  attr_reader :filename
  attr_reader :name
  attr_reader :period
  attr_reader :continent
  attr_reader :diet
  attr_reader :carnivore
  attr_reader :weight
  attr_reader :walking
  attr_reader :description

  def initialize(str, filename)
    @filename = filename
    process(str)
  end

  def print
    puts @name
  end

  def facts
    puts ""
    puts "Name: " + @name unless @name.nil? || @name.empty?
    puts "Period: " + @period unless @period.nil? || @period.empty?
    puts "Continent: " + @continent unless @continent.nil? || @continent.empty?
    puts "Diet: " + @diet unless @diet.nil? || @diet.empty?
    puts "Carnivore: " + @carnivore unless @carnivore.nil? || carnivore.empty?
    puts "Weight (lbs): " + @weight unless @weight.nil? || @weight.empty?
    puts "Walking: " + @walking unless @walking.nil? || @walking.empty?
    puts "Description: " + @description unless @description.nil? || @description.empty?
    puts ""
  end

  def process(str)
    ary = str.split(',')
    case 
    when @filename == "dinodex.csv" && ary.length == 7
      # NAME,PERIOD,CONTINENT,DIET,WEIGHT_IN_LBS,WALKING,DESCRIPTION
      @name = ary[0].chomp unless ary[0].nil?
      @period = ary[1].chomp unless ary[1].nil?
      @continent = ary[2].chomp unless ary[2].nil?
      @diet = ary[3].chomp unless ary[3].nil?
      @carnivore = nil
      @weight = ary[4].chomp unless ary[4].nil?
      @walking = ary[5].chomp unless ary[5].nil?
      @description = ary[6].chomp unless ary[6].nil?
    when "african_dinosaur_export.csv" && ary.length == 5
      # Genus,Period,Carnivore,Weight,Walking
      @name = ary[0].chomp unless ary[0].nil?
      @period = ary[1].chomp unless ary[1].nil?
      @continent = nil
      @diet = nil
      @carnivore = ary[2].chomp unless ary[2].nil?
      @weight = ary[3].chomp unless ary[3].nil?
      @walking = ary[4].chomp unless ary[4].nil?
      @description = nil
    else
      puts "Invalid database:"
      puts "dinodex.csv requires 7 columns"
      puts "african_dinosaur_export.csv requires 5 columns"
    end
  end
end
