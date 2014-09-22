require_relative "dino"

class DinoParser
  def self.can_parse?(data)
    (attribute_map.values.uniq - data.keys).empty?
  end

  def self.parse(data)
    options = Hash[attribute_map.map { |hash_key, data_key| 
      [hash_key, transform(hash_key, data[data_key])] }]
    Dino.new(options[:name], base.merge(options))
  end

  protected
  def self.base
    {}
  end

  def self.attribute_map
    {}
  end

  def self.transform(attr, data)
    data
  end
end

class FavoriteDinoParser < DinoParser
  CARNIVORE = %w"Carnivore Insectivore Piscivore"

  TRANSFORMS = {
    :carnivore => lambda { |v| CARNIVORE.include? v }
  }

  protected
  def self.attribute_map
    {
      :name => "NAME",
      :period => "PERIOD",
      :continent => "CONTINENT",
      :diet => "DIET",
      :carnivore => "DIET",
      :weight => "WEIGHT_IN_LBS",
      :walking => "WALKING",
      :description => "DESCRIPTION",
    }
  end

  def self.transform(attr, data)
    TRANSFORMS.has_key?(attr) ? TRANSFORMS[attr].call(data) : data
  end
end

class AfricanDinoParser < DinoParser
  TRANSFORMS = { 
    :carnivore => lambda { |v| v == "Yes" },
    :diet => lambda { |v| v == "Yes" ? "Carnivore" : "Herbivore" },
  }

  protected 
  def self.base
    {
      :continent => "Africa",
    }
  end

  def self.attribute_map
    {
      :name => "Genus",
      :period => "Period",
      :diet => "Carnivore",
      :carnivore => "Carnivore",
      :weight => "Weight",
      :walking => "Walking",
    }
  end

  def self.transform(attr, data)
    TRANSFORMS.has_key?(attr) ? TRANSFORMS[attr].call(data) : data
  end
end

