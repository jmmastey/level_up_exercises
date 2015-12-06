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
    region_error unless CLASSIFICATIONS.include? region
    shapes = CLASSIFICATIONS[region]
    shape_error unless shapes.include? shape
    arrowhead = shapes[shape]
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.region_error
    raise "Uknown region, please provide a valid region."
  end

  def self.shape_error
    raise "Uknown shape value. Are you sure you know what you're talking about?"
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
