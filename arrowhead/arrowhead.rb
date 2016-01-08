class Arrowhead
  # Error Messages
  BAD_REGION = "Unknown region, please provide a valid region."
  BAD_SHAPE = "Unknown shape value. please provide a valid shape"

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

  def self.valid_shape?(shapes, shape)
    shapes.include? shape
  end

  def self.classify(region, shape)
    return raise BAD_REGION unless valid_region?(region)
    shapes = CLASSIFICATIONS[region]
    return raise BAD_SHAPE unless valid_shape?(shapes, shape)
    arrowhead = shapes[shape]
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
