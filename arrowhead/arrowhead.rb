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
    regional_shapes = shapes_in_region(region)
    classify_by_shape(regional_shapes, shape)
  end

  def self.shapes_in_region(region)
    if CLASSIFICATIONS.include? region
      return CLASSIFICATIONS[region]
    else
      raise "Unknown region, please provide a valid region."
    end
  end

  def self.classify_by_shape(shapes, shape)
    if shapes.include? shape
      return "You have a(n) '#{shapes[shape]}' arrowhead. Probably priceless."
    else
      raise "Unknown shape value. Are you sure you know what you're talking about?"
    end
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
