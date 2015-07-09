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

  def self.get_region(region)
    unless CLASSIFICATIONS.include?(region)
      raise "Unknown region, please provide a valid region."
    end

    CLASSIFICATIONS[region]
  end

  def self.get_shape(shapes, shape)
    unless shapes.include?(shape)
      raise "Unknown shape value. Are you sure you know what " \
            "you're talking about?"
    end

    shapes[shape]
  end

  def self.classify(region, shape)
    shapes = get_region(region)
    arrowhead = get_shape(shapes, shape)

    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
