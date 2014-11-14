class Dinosaurs
  attr_reader :name, :period, :continent, :diet, :weight, :walking
  attr_reader :description

  def initialize(options)
    @name = options[:name].to_s
    @period = options[:period].to_s
    @continent = options[:continent] || "Africa"
    @diet = convert_diet(options[:diet])
    @weight = options[:weight_in_lbs] || "Unknown"
    @walking = options[:walking].to_s
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

  def to_json(*args)
    to_hash.to_json(*args)
  end

  private

  def to_hash
    hash = {}
    instance_variables.each do |var|
      hash[var.to_s.delete("@")] = instance_variable_get(var)
    end
    hash
  end
end
