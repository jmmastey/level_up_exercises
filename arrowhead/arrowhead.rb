class Arrowhead
  # This seriously belongs in a database.
  attr_reader :region, :shape
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

  def initialize(region, shape)
    @region = region_handler(region)
    @shape = shape_handler(shape)
  end

  def region_handler(region)
    raise "Unknown region, please " \
          "provide a valid region." unless CLASSIFICATIONS.include? region
    region
  end

  def shape_handler(shape)
    raise "Unknown shape value. Are you sure " \
          "you know what you're talking about?" \
          unless CLASSIFICATIONS[region].include? shape
    shape
  end

  def classify
    arrowhead = CLASSIFICATIONS[region][shape]
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.new(:northern_plains, :bifurcated).classify
