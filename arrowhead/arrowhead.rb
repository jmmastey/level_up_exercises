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

  def self.get_region_shapes(region)
    if CLASSIFICATIONS.include? region
      CLASSIFICATIONS[region]
    else
      raise "Unknown region, please provide a valid region."
    end
  end

  def self.get_shape(region_shapes, shape)
    if region_shapes.include? shape
      arrowhead = region_shapes[shape]
      "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    else
      raise "Unknown shape value. Are you sure you know what " \
        "you're talking about?"
    end
  end

  def self.classify(region, shape)
    region_shapes = get_region_shapes region
    get_shape(region_shapes, shape)
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
