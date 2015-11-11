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

  def self.classify(region, shape)
    if valid_region(region) && valid_shape(region, shape)
      "You have a(n) '#{valid_shape(region, shape)}' arrowhead. Probably priceless."
    elsif !(valid_region(region))
      region_error
    else
      shape_error
    end
  end

  def self.valid_region(region)
    CLASSIFICATIONS[region]
  end

  def self.valid_shape(region, shape)
    CLASSIFICATIONS[region][shape] if valid_region(region)
  end

  def self.shape_error
    raise "Unknown shape value - sure you know what you're talking about?"
  end

  def self.region_error
    raise "Unknown region, please provide a valid region."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)

# Nonexistent region
# puts Arrowhead.classify(:tundra, :bifurcated)

# Nonexistent shape
# puts Arrowhead.classify(:far_west, :stoney)
