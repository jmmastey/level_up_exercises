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
    if check_status(region, shape)
      arrowhead = CLASSIFICATIONS[region][shape]
      puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    end
  end

  def self.check_status(region, shape)
    if valid_region?(region) && valid_shape?(region, shape)
      return true
    elsif valid_region?(region)
      raise NameError, ERRORS[:shape]
    else
      raise NameError, ERRORS[:region]
    end
  end

  def self.valid_region?(region)
    CLASSIFICATIONS.include?(region)
  end

  def self.valid_shape?(region, shape)
    CLASSIFICATIONS[region].include?(shape)
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
