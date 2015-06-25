class Arrowhead
  REGION_IS_INVALID = "Unknown region. Please provide a valid region."
  SHAPE_IS_INVALID = "Unknown shape. Please provide a valid shape."

  # This seriously belongs in a database.
  CLASSIFICATIONS = {
    far_west: {
      notched: "Archaic Side Notch",
      stemmed: "Archaic Stemmed",
      lanceolate: "Agate Basin",
      bifurcated: "Cody",
    },
    northern_plains: {
      notched: "Besant",
      stemmed: "Archaic Stemmed",
      lanceolate: "Humboldt Constricted Base",
      bifurcated: "Oxbow",
    },
  }

  def self.valid_region?(region)
    CLASSIFICATIONS.include? region
  end

  def self.valid_shape?(region, shape)
    CLASSIFICATIONS[region].include? shape
  end

  # FIXME: I don't have time to deal with this.
  def self.classify(region, shape)
    raise REGION_IS_INVALID unless valid_region?(region)
    raise SHAPE_IS_INVALID  unless valid_shape?(region, shape)
    arrowhead = CLASSIFICATIONS[region][shape]
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
