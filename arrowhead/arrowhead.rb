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

  REGION_ERROR = "Unknown region, please provide a valid region.".freeze

  # FIXME: I don't have time to deal with this.
  def self.classify(region, shape)
    shapes = self.find_region(region)
    self.find_shape(shapes, shape)
  end

  def self.find_region(region)
    if CLASSIFICATIONS.include? region
      CLASSIFICATIONS[region]
    else
      raise REGION_ERROR
    end
  end

  def self.find_shape(shapes, shape)
    if shapes.include? shape
      arrowhead = shapes[shape]
      "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    else
      raise "Unknown shape value. Are you sure you know what you're talking about?"
    end
  end
end



puts Arrowhead.classify(:northern_plains, :bifurcated)
