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
  def self.classify(region, arrowhead_shape)
    regional_shapes = CLASSIFICATIONS[region]
    determine_arrowhead(regional_shapes, arrowhead_shape) if region_exists?(region)
  end

  def self.determine_arrowhead(shapes_in_region, shape)
    if shapes_in_region.include? shape
      arrowhead = shapes_in_region[shape]
      puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    else
      raise "Unknown shape value. Are you sure you know what you're talking about?"
    end
  end

  def self.region_exists?(region)
    if CLASSIFICATIONS.include? region
      true
    else
      raise "Unknown region, please provide a valid region."
    end
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
