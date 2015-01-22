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

  # FIXME: I don't have time to deal with this.

  def self.classify(region, shape)
    arrowhead = CLASSIFICATIONS[region][shape] if self.has_region?(region) && self.has_shape?(region, shape)
    if arrowhead
      puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    end
  end

  def self.has_region?(region)
    if CLASSIFICATIONS[region].nil?
      ErrorHandler.no_region
    else
      true
    end
  end

  def self.has_shape?(region, shape)
    if CLASSIFICATIONS[region][shape].nil?
      ErrorHandler.no_shape
    else
      true
    end
  end

end

class ErrorHandler
  def self.no_shape
    raise "Unknown shape value. Are you sure you know what you're talking about?"
  end

  def self.no_region
    raise "Unknown region, please provide a valid region"
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
