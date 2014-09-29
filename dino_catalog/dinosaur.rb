class Dinosaur
  attr_accessor :name, :period, :diet, :weight, :walking, :continent, 
                  :description, :weight_classification

  def to_s
    #TODO figure out better way to filter/display values
    if name
      puts "Name: " + name.to_s
    end
    if period
      puts "Period: " + period.to_s
    end
    if diet
      puts "Diet: " + diet.to_s
    end
    if weight
      puts "Weight: " + weight.to_s
    end
    if walking
      puts "Walking: " + walking.to_s
    end
    if continent
      puts "Continent: " + continent.to_s
    end
    if description
      puts "Description: " + description.to_s
    end

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
end
