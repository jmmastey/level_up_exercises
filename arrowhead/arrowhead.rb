class Arrowhead
  REGION_ERROR = "Unknown region, please provide a valid region."
  SHAPE_ERROR =
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
    raise REGION_ERROR unless CLASSIFICATIONS.include?(region)

    shapes = CLASSIFICATIONS[region]
    raise SHAPE_ERROR unless shapes.include?(shape)

    puts "You have a(n) '#{shapes[shape]}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
