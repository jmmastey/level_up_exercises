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

  def self.classify(region, shape)

    raise 'Unknown region, please provide a valid region.' unless self.isRegion(region)
    raise  "Unknown shape value. Are you sure you know what you're talking about?" unless self.isShape(region, shape)

    arrowhead = CLASSIFICATIONS[region][shape]
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."

  end

  def self.isRegion(region)
    CLASSIFICATIONS.include? region
  end

  def self.isShape(region, shape)
    CLASSIFICATIONS[region].include? shape
  end

end
puts Arrowhead.classify(:northern_plains, :bifurcated)
