class Arrowhead

  class InvalidRegionError < RuntimeError
    def to_s
      "Unknown region, please provide a valid region."
    end
  end

  class InvalidShapeError < RuntimeError
    def to_s
      "Unknown shape value. Are you sure you know what you're talking about?"
    end
  end

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

  def self.classify(target_region, target_shape)
    shapes = classify_region(target_region)
    classify_shape(shapes, target_shape).tap do |this|
      puts "You have a(n) '#{this}' arrowhead. Probably priceless."
    end
  end

  def self.classify_region(region)
    CLASSIFICATIONS.fetch(region) { raise InvalidRegionError }
  end

  def self.classify_shape(shapes, target_shape)
    shapes.fetch(target_shape) { raise InvalidShapeError }
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
