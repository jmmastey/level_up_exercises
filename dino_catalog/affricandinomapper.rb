require_relative "hashmapper"

class AfricanDinoMapper
  include HashMapper
  TRANSFORMS = { 
    :carnivore => lambda { |v| v == "Yes" },
    :diet => lambda { |v| v == "Yes" ? "Carnivore" : "Herbivore" },
    :continent => lambda { |_| "Africa" },
  }

  ATTRIBUTE_MAP = {
    :name => "Genus",
    :period => "Period",
    :diet => "Carnivore",
    :carnivore => "Carnivore",
    :weight => "Weight",
    :walking => "Walking",
    :continent => nil,
  }

  protected 
  def attribute_map
    ATTRIBUTE_MAP
  end

  def transform(attr, data)
    TRANSFORMS.has_key?(attr) ? TRANSFORMS[attr].call(data) : data
  end
end
