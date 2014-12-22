class Arrowhead
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
    case
    when !region_exists?(region) then unknown_region
    when !shape_exists?(shape, region) then unknown_shape
    else puts print_arrowhead(CLASSIFICATIONS[region][shape])
    end
  end

  def self.region_exists?(region)
    CLASSIFICATIONS.include? region
  end

  def self.shape_exists?(shape, region)
    CLASSIFICATIONS[region].include? shape
  end

  def self.print_arrowhead(shape)
    puts "You have a(n) '#{shape}' arrowhead. Probably priceless."
  end

  def self.unknown_shape
    raise "Unknown shape value. Are you sure you know what you're talking about?"
  end

  def self.unknown_region
    raise "Unknown region. Please provide a valid region."
  end

end

puts Arrowhead.classify(:northern_plains, :bifurcated)
