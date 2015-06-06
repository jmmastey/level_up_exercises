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

  INVALID_REGION = 0
  INVALID_SHAPE = 1
  VALID_REGION_SHAPE = 2

  # FIXME: I don't have time to deal with this.
  def self.classify(region, shape)
    state = check_status(region, shape)
    case state
    when VALID_REGION_SHAPE
      arrowhead = CLASSIFICATIONS[region][shape]
      puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    when INVALID_SHAPE
      puts "Unknown shape value. Are you sure you know what you're talking about?"
    when INVALID_REGION
      puts "Unknown region, please provide a valid region."
    end
  end

  def check_status(region, shape)
    if valid_region?(region) && valid_shape?(region, shape)
      VALID_REGION_SHAPE
    elsif valid_region?(region)
      INVALID_SHAPE
    else
      INVALID_REGION
    end
  end

  def valid_region?(region)
    CLASSIFICATIONS.include? region
  end

  def valid_shape?(region, shape)
    CLASSIFICATIONS[region].include? shape
  rescue
    false
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
