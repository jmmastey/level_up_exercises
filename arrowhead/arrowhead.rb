ArrowHeadError = Class.new(RuntimeError)
InvalidRegionError = Class.new(ArrowHeadError)
InvalidShapeError = Class.new(ArrowHeadError)

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
    if CLASSIFICATIONS.include? region
      region
    else
      raise InvalidRegionError, "Invalid Region"
    end
  end

  def shape_handler(shape)
    if CLASSIFICATIONS[region].include? shape
      shape
    else
      raise InvalidShapeError, "Invalid Shape"
    end
  end

  def classify
    arrowhead = CLASSIFICATIONS[region][shape]
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.new(:northern_plains, :bifurcated).classify
