class Dinosaur
  attr_accessor :name, :period, :diet, :weight, :walking, :continent, 
                  :description, :weight_classification

  def initialize(properties)
    @name = properties[:name]
    @period = properties[:period]
    @diet = properties[:diet]
    @weight = properties[:weight]
    @walking = properties[:walking]
    @continent = properties[:continent]
    @description = properties[:description]
    @weight_classification = determine_weight_classification
  end

  def to_s
    output = []

    output << "---"
    output << "Name: " + name.to_s if name
    output << "Period: " + period.to_s if period
    output << "Diet: " + diet.to_s if diet
    output << "Weight: " + weight.to_s if weight
    output << "Walking: " + walking.to_s if walking
    output << "Continent: " + continent.to_s if continent
    output << "Description: " + description.to_s if description

    output.join("\n")
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

  def determine_weight_classification
    # 2204 is one metric ton represented as pounds (lbs)
    if @weight.to_i > (2204 * 2)
      "big"
    elsif @weight.to_i > 0
      "small"
    else
      nil
    end
  end

  def to_json(*args)
    to_hash.to_json(*args)
  end
end
