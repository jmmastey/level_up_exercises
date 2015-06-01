class Arrowhead
  INVALID_REGION_MSG = "Unknown region, please provide a valid region."
  INVALID_SHAPE_MSG = "Unknown shape value. Are you sure you know what you're"\
                      " talking about?"
  SUCCESS_SHAPE = lambda do |var|
    "You have a(n) '#{var}' arrowhead. Probably priceless."
  end

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

  def self.known_region?(region)
    CLASSIFICATIONS.include? region
  end

  def self.known_shape?(region, shape)
    CLASSIFICATIONS[region].include? shape
  end

  def self.classify(region, shape)
    raise INVALID_REGION_MSG unless known_region?(region)
    raise INVALID_SHAPE_MSG unless known_shape?(region, shape)
    arrowhead = CLASSIFICATIONS[region][shape]
    puts SUCCESS_SHAPE.call arrowhead
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
