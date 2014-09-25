require_relative "hashmapper"

class AfricanDinoMapper
  include HashMapper
  TRANSFORMS = {
    carnivore: ->(v) { v == "Yes" },
    diet: ->(v) { v == "Yes" ? "Carnivore" : "Herbivore" },
    continent: ->(_) { "Africa" },
  }
  TRANSFORMS.default = ->(v) { v }

  KEY_MAP = {
    name: "Genus",
    period: "Period",
    diet: "Carnivore",
    carnivore: "Carnivore",
    weight: "Weight",
    walking: "Walking",
    continent: nil,
  }

  protected

  def key_map
    KEY_MAP
  end

  def transform(attr, data)
    TRANSFORMS[attr].call(data)
  end
end
