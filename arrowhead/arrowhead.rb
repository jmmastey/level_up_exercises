# Classify arrowheads based on region and shape
class Arrowhead
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
    return true if CLASSIFICATIONS.include? region

    raise "Unknown region, please provide a valid region."
  end

  def self.valid_shape?(shape, shape_set)
    return true if shape_set.include? shape

    raise "Unknown shape value. Are you sure you know what you're talking about?"
  end

  def self.get_shape_set(region)
    CLASSIFICATIONS[region] if valid_region?(region)
  end

  def self.get_shape(shape, shape_set)
    shape_set[shape] if valid_shape?(shape, shape_set)
  end

  def self.classify(region, shape)
    arrowhead = get_shape(shape, get_shape_set(region))

    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
