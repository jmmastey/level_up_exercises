class Arrowhead
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

  ERRORS = {
    unknown_region: "Unknown region, please provide a valid region.",
    unknown_shape: "Unknown shape value. Are you sure you know what you're talking about?",
  }

  def self.classify(region, shape)
    raise ERRORS[unknown_region] unless CLASSIFICATIONS.include? region
    shapes = CLASSIFICATIONS[region]
    raise ERRORS[unknown_shape] unless shapes.include? shape
    arrowhead = shapes[shape]
    p "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
