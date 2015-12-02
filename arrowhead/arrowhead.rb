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
    shapes = check_region(region)
    arrowhead = check_shape(shapes, shape)
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.check_region(region)
    raise "Uknown region, please provide a valid region." unless CLASSIFICATIONS.include? region
    CLASSIFICATIONS[region]
  end

  def self.check_shape(shapes, shape)
    raise "Uknown shape value. Are you sure you know what you're talking about?" unless shapes.include? shape
    shapes[shape]
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
