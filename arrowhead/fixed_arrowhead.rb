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

  REGION_MESSAGE = "Unknown region, please provide a valid region."
  SHAPE_MESSAGE = "Unknown shape value. What you talking about, Willis?"

  # FIXME: I don't have time to deal with this.
  def self.classify(region, shape)
    raise REGION_MESSAGE unless CLASSIFICATIONS.include?(region)
    shapes = CLASSIFICATIONS[region]
    raise SHAPE_MESSAGE unless shapes.include?(shape)
    puts "You have a(n) '#{shapes[shape]}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
