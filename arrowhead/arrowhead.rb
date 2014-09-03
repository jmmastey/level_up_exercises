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

    raise "Unknown region, please provide a valid
      region." if CLASSIFICATIONS[region].nil?

    raise "Unknown shape value. Are you sure you know
      what you're talking about?" if !CLASSIFICATIONS[region].key? shape

    arrowhead = CLASSIFICATIONS[region].fetch shape
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

Arrowhead::classify(:northern_plains, :bifurcated)
