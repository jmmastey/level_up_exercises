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
    arrowhead = arrowhead_for(region, shape)
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.arrowhead_for(region, shape)
    shapes_for(region)[shape] ||
      raise("Unknown shape value, please provide a valid shape.")
  end

  def self.shapes_for(region)
    CLASSIFICATIONS[region] ||
      raise("Unknown region, please provide a valid region.")
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
