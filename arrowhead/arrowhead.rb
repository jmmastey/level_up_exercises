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
    shapes = CLASSIFICATIONS[region]
    if check_region(region) && check_shape(shapes, shape)
      arrowhead = shapes[shape]
      "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    end
  end

  def self.check_region(region)
    CLASSIFICATIONS.include? region || (raise "Unknown region, please provide a valid region.")
  end

  def self.check_shape(all_shapes, shape)
    all_shapes.include? shape || (raise "Unknown shape value. Are you sure you know what you're talking about?")
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)