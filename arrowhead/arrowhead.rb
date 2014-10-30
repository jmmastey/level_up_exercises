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
    determine_arrowhead(region, shape) if region?(region)
  end

  def self.determine_arrowhead(region, shape)
    shapes = CLASSIFICATIONS[region]
    if shapes.include? shape
      arrowhead = shapes[shape]
      puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    else
      raise "Unknown shape value. Are you sure you know what you're talking about?"
    end
  end

  def self.region?(region)
    if CLASSIFICATIONS.include? region
      true
    else
      raise "Unknown region, please provide a valid region."
    end
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
