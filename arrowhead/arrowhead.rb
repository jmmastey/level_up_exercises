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

  ERRORS = {
    shape: "Unknown shape value. Are you sure you know what you're talking about?",
    region: "Unknown region, please provide a valid region"
  }

  def self.classify(region, shape)
    check_status(region, shape)
    arrowhead = CLASSIFICATIONS[region][shape]
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.check_status(region, shape)
    raise NameError, ERRORS[:region] unless valid_region?(region)
    raise NameError, ERRORS[:shape] unless valid_shape?(region, shape)
  end

  def self.valid_region?(region)
    CLASSIFICATIONS.include?(region)
  end

  def self.valid_shape?(region, shape)
    CLASSIFICATIONS[region].include?(shape)
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
