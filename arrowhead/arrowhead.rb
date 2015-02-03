class Arrowhead
  # Exception msgs
  UNKNOWN_REGION_EXCEPTION = "Unknown region, please provide a valid region."
  UNKNOWN_SHAPE_EXCEPTION =
    "Unknown shape value. Are you sure you know what you're talking about?"

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
    raise UNKNOWN_REGION_EXCEPTION unless CLASSIFICATIONS.include? region
    shapes = CLASSIFICATIONS[region]

    raise UNKNOWN_SHAPE_EXCEPTION unless shapes.include? shape
    puts "You have a(n) '#{shapes[shape]}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
