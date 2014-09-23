require_relative "hashmapper"

class FavoriteDinoMapper
  include HashMapper
  CARNIVORE = %w"Carnivore Insectivore Piscivore"

  TRANSFORMS = {
    :carnivore => lambda { |v| CARNIVORE.include? v }
  }
  TRANSFORMS.default = lambda { |v| v }

  KEY_MAP = {
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
  def key_map
    KEY_MAP
  end

  def transform(attr, value)
    TRANSFORMS[attr].call(value)
  end
end
