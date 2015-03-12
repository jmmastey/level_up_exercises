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

  ERR_SHAPE = "Unknown shape value. " \
              "Are you sure you know what you're talking about?"
  ERR_REGION = "Unknown region, please provide a valid region."

  def self.classify(region, shape)
    raise ERR_REGION unless CLASSIFICATIONS.include? region

    shapes = CLASSIFICATIONS[region]
    raise ERR_SHAPE unless shapes.include? shape

    arrowhead = shapes[shape]
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
