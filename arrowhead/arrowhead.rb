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

  def self.classify(region, shape)
    raise "Please provide valid region" unless CLASSIFICATIONS.include?(region)

    shapes = CLASSIFICATIONS[region]
    raise "Please provide valid shape" unless shapes.include?(shape)

    arrowhead = shapes[shape]
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
