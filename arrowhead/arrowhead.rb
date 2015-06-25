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

  def self.valid_region(region)
    CLASSIFICATIONS.include? region
  end

  def self.valid_shape(region, shape)
    CLASSIFICATIONS[region].include? shape
  end

  # FIXME: I don't have time to deal with this.
  def self.classify(region, shape)
    if valid_region(region)
      shapes = CLASSIFICATIONS[region]
      if valid_shape(region, shape)
        arrowhead = shapes[shape]
        "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
      else
        raise "Unknown shape value. Are you sure you know what you're talking about?"
      end
    else
      raise "Unknown region, please provide a valid region."
    end
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
