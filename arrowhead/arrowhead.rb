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

  def self.is_valid_region(region)
    if CLASSIFICATIONS.include? region
      true
    else
      raise "Unknown region, please provide a valid region."
    end
  end

  def self.is_valid_shape(shape, shape_set)
    if shape_set.include? shape
      true
    else
      raise "Unknown shape value. Are you sure you know what you're talking about?"
    end
  end

  def self.get_shape_set(region)
    if is_valid_region(region)
      CLASSIFICATIONS[region]
    end
  end

  def self.get_shape(shape, shape_set)
    if is_valid_shape(shape, shape_set)
      shape_set[shape]
    end
  end

  def self.classify(region, shape)
    shapes = get_shape_set(region)

    arrowhead = get_shape(shape, shapes)

    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
