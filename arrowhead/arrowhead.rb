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
    if CLASSIFICATIONS.include? region
      classify_shape_for_specfic_region region, shape
    else
      raise "Unknown region, please provide a valid region."
    end
  end

  private_class_method :new
  def self.classify_shape_for_specfic_region(region, shape)
    shapes = CLASSIFICATIONS[region]
    if shapes.include? shape
      "You have a(n) '#{shapes[shape]}' arrowhead. Probably priceless."
    else
      raise "Unknown shape value."\
            " Are you sure you know what you're talking about?"
    end
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
