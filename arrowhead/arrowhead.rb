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

  # FIXME: I don't have time to deal with this.
  def self.classify(region, shape)
    shapes = region_shape(region)
    arrowhead = shape_arrowhead(shapes, shape)
    print_arrowhead(arrowhead)
  end

  def self.print_arrowhead(arrowhead)
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.region_shape(region)
    raise region_error unless CLASSIFICATIONS.include?(region)
    CLASSIFICATIONS[region]
  end

  def self.shape_arrowhead(shapes, shape)
    raise shape_error unless shapes.include?(shape)
    shapes[shape]
  end

  def self.region_error
    "Unknown region, please provide a valid region."
  end

  def self.shape_error
    "Unknown shape value. Are you sure you know what you're talking about?"
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
