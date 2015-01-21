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
    shapes = CLASSIFICATIONS[region]
    raise "Unknown region, please provide a valid region." unless shapes
    identify_shape(shapes, shape)
  end

  def self.identify_shape(shapes, type)
    shape = shapes[type]
    shape_error unless shape
    "You have a(n) '#{shape}' arrowhead. Probably priceless."
  end

  def shape_error
    raise "Unknown shape value. Are you sure you know what you're \
      talking about?"
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
