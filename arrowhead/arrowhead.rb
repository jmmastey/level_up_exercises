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
    CLASSIFICATIONS.include? region
  end

  def self.valid_shape?(shape, shape_group)
    shape_group.include? shape
  end

  def self.get_shape_group(region)
    if valid_region?(region)
      CLASSIFICATIONS[region]
    else
      raise "Unknown region, please provide a valid region."
    end
  end

  def self.get_shape(shape, shape_group)
    if valid_shape?(shape, shape_group)
      shape_group[shape]
    else
      raise "Unknown shape value. Are you sure you know what you're talking
            about?"
    end
  end

  def self.classify(region, shape)
    arrowhead = get_shape(shape, get_shape_group(region))

    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
