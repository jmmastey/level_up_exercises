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
    arrowhead = select_arrowhead_by_shape(shape, get_region_shapes(region))
    print_arrowhead(arrowhead)
  end

  def self.print_arrowhead(arrowhead)
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
  private_class_method :print_arrowhead

  def self.get_region_shapes(region)
    CLASSIFICATIONS[region] ||
      raise("Unknown region, please provide a valid region.")
  end
  private_class_method :get_region_shapes

  def self.select_arrowhead_by_shape(shape, region_shapes)
    message = "Unknown shape value. "
    message += "Are you sure you know what you're talking about?"
    region_shapes[shape] || raise(message)
  end
  private_class_method :select_arrowhead_by_shape
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
