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

  def self.known_region?(region)
    if CLASSIFICATIONS.include? region
      true
    else
      puts "Unknown region, please provide a valid region."
      false
    end
  end

  def self.known_shape?(region, shape)
    if CLASSIFICATIONS[region].include? shape
      true
    else
      puts "Unknown shape value. Are you sure you know what you're"\
         " talking about?"
      false
    end
  end

  def self.classify(region, shape)
    if known_region?(region) && known_shape?(region, shape)
      arrowhead = CLASSIFICATIONS[region][shape]
      puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    end
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
