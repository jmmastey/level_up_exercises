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
    arrowhead = get_arrowhead(region, shape)
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.get_arrowhead(region, shape)
    shapes = get_shapes(region)
    if shapes.include? shape
      shapes[shape]
    else
      raise "Unknown shape value, please provide a valid shape."
    end
  end

  def self.get_shapes(region)
    if CLASSIFICATIONS.include? region
      CLASSIFICATIONS[region]
    else
      raise "Unknown region, please provide a valid region."
    end
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
