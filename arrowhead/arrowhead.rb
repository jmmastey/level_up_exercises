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
    shapes = CLASSIFICATIONS[region] unless check_region(region)
    arrowhead = shapes[shape] unless check_shape(shapes, shape)
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  private
  def self.check_region(region)
    unless CLASSIFICATIONS.include? region
      raise "Uknown region, please provide a valid region."
    end
  end

  def self.check_shape(shapes, shape)
    unless shapes.include? shape
      raise "Uknown shape value. Are you sure you know what you're talking about?"
    end
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
