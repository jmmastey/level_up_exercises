class Dinosaur
  attr_reader :name, :period, :continent, :diet, :weight, :legs, :description
  def initialize(options)
    @name = options[:name].to_s
    @period = options[:period].to_s
    @continent = options[:continent] || "Africa"
    @diet = convert_diet(options[:diet])
    @weight = options[:weight_in_lbs] || "Unknown"
    @legs = options[:walking].to_s
    @description = options[:description].to_s
  end

  def convert_diet(food)
    if food == "Yes"
      "Carnivore"
    elsif food == "No"
      "Herbivore"
    else
      food
    end
  end
end
