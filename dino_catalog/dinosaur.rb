class Dinosaur
  #one metric ton as pounds
  TON_AS_POUNDS = 2204

  attr_accessor :name, :period, :diet, :weight, :walking, :continent, 
                  :description, :weight_classification

  def to_s
    puts "Name: " + name.to_s if name
    puts "Period: " + period.to_s if period
    puts "Diet: " + diet.to_s if diet
    puts "Weight: " + weight.to_s if weight
    puts "Walking: " + walking.to_s if walking
    puts "Continent: " + continent.to_s if continent
    puts "Description: " + description.to_s if description

    puts "\r"
  end

  def to_hash
    {
      :name => name,
      :period => period,
      :diet => diet,
      :weight => weight,
      :walking => walking,
      :continent => continent,
      :description => description,
    }
  end

  def self.determine_weight_classification(weight)
    if weight.to_i > (TON_AS_POUNDS * 2)
      "big"
    elsif weight.to_i > 0
      "small"
    else
      nil
    end
  end
end
