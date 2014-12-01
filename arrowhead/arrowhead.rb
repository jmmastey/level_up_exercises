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

  attr_reader :region, :shape

  def initialize(region, shape)
    @region = check_region(region)
    @shape = check_shape(shape)
  end

  def check_region(region)
   return region if CLASSIFICATIONS.include? region
   raise "Unknown region, please provide a valid region."
  end

  def check_shape(shape)
    return shape if CLASSIFICATIONS[region].include? shape
    raise "Unknown shape value. Are you sure you know what you're talking about?"
  end

  def classify
    arrowhead = CLASSIFICATIONS[region][shape]
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.new(:northern_plains, :bifurcated).classify
