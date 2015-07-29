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
  def self.classify_shape(shapes, shape)
    raise ArgumentError, "Unknown shape value" unless shapes.include? shape
    arrowhead = shapes[shape]
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.classify_region(region, shape)
    regions = CLASSIFICATIONS.keys
    raise ArgumentError, "Unknown region entered" unless regions.include? region
    shapes = CLASSIFICATIONS[region]
    classify_shape(shapes, shape)
  end
end

puts Arrowhead.classify_region(:northern_plains, :bifurcated)
puts Arrowhead.classify_region(:n, :bifurcated)
