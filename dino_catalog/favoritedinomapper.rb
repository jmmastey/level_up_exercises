require_relative "hashmapper"

class FavoriteDinoMapper
  include HashMapper
  CARNIVORE = %w"Carnivore Insectivore Piscivore"

  TRANSFORMS = {
    :carnivore => lambda { |v| CARNIVORE.include? v }
  }

  ATTRIBUTE_MAP = {
    :name => "NAME",
    :period => "PERIOD",
    :continent => "CONTINENT",
    :diet => "DIET",
    :carnivore => "DIET",
    :weight => "WEIGHT_IN_LBS",
    :walking => "WALKING",
    :description => "DESCRIPTION",
  }

  protected
  def attribute_map
    ATTRIBUTE_MAP
  end

  def transform(attr, value)
    TRANSFORMS.has_key?(attr) ? TRANSFORMS[attr].call(value) : value
  end
end
