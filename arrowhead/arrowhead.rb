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
    shapes = CLASSIFICATIONS[region] if check_region(region)
    arrowhead = shapes[shape] if check_shape(shapes, shape)
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  private
  def self.check_region(region)
    if CLASSIFICATIONS.include? region
      true
    else
      raise "Uknown region, please provide a valid region."
    end
  end

  def self.check_shape(shapes, shape)
    if shapes.include? shape
      true
    else
      raise "Uknown shape value. Are you sure you know what you're talking about?"
    end
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
