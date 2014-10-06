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

  def self.verify_shape(region, shape)
    CLASSIFICATIONS[region][shape] ||
      raise("Unknown shape value. Are you sure you know what you're talking about?")
  end

  def self.verify_region(region, shape)
    verify_shape(region, shape) ||
      raise("Unknown region, please provide a valid region.")
  end

  def self.classify(region, shape)
    arrowhead = verify_region(region, shape)
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
puts Arrowhead.classify(:far_west, :stemmed)
