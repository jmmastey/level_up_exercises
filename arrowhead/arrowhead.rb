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
    return identify_shape(region, shape) if CLASSIFICATIONS.include? region
    raise "Unknown region, please provide a valid region."
  end

  def self.identify_shape(region, shape)
    shapes = CLASSIFICATIONS[region]
    shape_error unless shapes.include? shape
    "You have a(n) '#{shapes[shape]}' arrowhead. Probably priceless."
  end

  def shape_error
    raise "Unknown shape value. Are you sure you know what you're \
      talking about?"
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
