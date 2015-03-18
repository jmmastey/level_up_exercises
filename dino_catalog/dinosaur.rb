class Dinosaur
  attr_reader :name, :period, :continent, :diet, :weight, :walk, :descrp

  def initialize(dino = {})
    @name = dino[:name] || dino[:genus]
    @period = dino[:period]
    @continent = dino[:continent] || 'African'
    @diet = dino[:diet] || convert_to_carnivore(dino[:carnivore])
    @weight = dino[:weight_in_lbs] || dino[:weight]
    @weight = @weight.to_i
    @walk = dino[:walking]
    @description = dino[:description]
  end

  def convert_to_carnivore(arg)
      "Carnivore" if arg == "Yes"
  end
  
  def display
    puts "NAME: #{@name}\n" if @name
    puts "PERIOD: #{@period}\n" if @period
    puts "CONTINENT: #{@continent}\n" if @continent
    puts "DIET: #{@diet}\n" if @diet
    puts "WEIGHT: #{@weight} lbs\n" if @weight.nonzero?
    puts "WALK: #{@walk}\n" if @walk
    puts "DESCRIPTION: #{@description}\n" if @description
  end
end
