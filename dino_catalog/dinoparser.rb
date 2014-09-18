require_relative "dino"

class DinoParser
  def can_parse?(data)
    data && attribute_map.keys.all? { |attr| data.has_key? attr}
  end

  def parse(data)
    options = Hash[attribute_map.map { |a, v| [v, transform(a, data[a])] }]
    Dino.new(options[:name], base.merge(options))
  end

  protected
  def base
    {}
  end

  def attribute_map
  end

  def transform(attr, data)
    data
  end
end

class FavoriteDinoParser < DinoParser
  protected
  def attribute_map
    {
      "NAME" => :name,
      "PERIOD" => :period,
      "CONTINENT" => :continent,
      "DIET" => :diet,
      "WEIGHT_IN_LBS" => :weight,
      "WALKING" => :walking,
      "DESCRIPTION" => :description,
    }
  end
end

class AfricanDinoParser < DinoParser
  TRANSFORMS = { 
    "Carnivore" => lambda { |v| v == "Yes" ? "Carnivore" : "Herbivore" },
  }

  protected 
  def base
    {
      :continent => "Africa",
    }
  end

  def attribute_map
    {
      "Genus" => :name,
      "Period" => :period,
      "Carnivore" => :diet,
      "Weight" => :weight,
      "Walking" => :walking,
    }
  end

  def transform(attr, data)
    TRANSFORMS.has_key?(attr) ? TRANSFORMS[attr].call(data) : data
  end
end
