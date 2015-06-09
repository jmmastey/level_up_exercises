class Arrowhead
  attr_reader :classifications

  def initialize(classifications)
    @classifications = classifications
  end

  def region_check(region)
    raise "Unknown region, please provide a valid region." \
    unless classifications.include? region
  end

  def shape_check(region, input_shape)
    if classifications[region].include? input_shape
      arrowhead = classifications[region][input_shape]
      puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    else
      raise "Unknown shape value. Are you sure you know \
      what you're talking about?"
    end
  end

  def classify(region, input_shape)
    region_check(region)
    shape_check(region, input_shape)
  end
end

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

Arrowhead_first = Arrowhead.new(CLASSIFICATIONS)
puts Arrowhead_first.classify(:northern_plains, :bifurcated)
