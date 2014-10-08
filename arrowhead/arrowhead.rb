# Classify arrowheads based on region and shape
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

  attr_accessor :region, :shape, :shape_group

  def initialize(region, shape)
    @region = region
    @shape = shape
    @shape_group = find_shape_group
  end

  def valid_region?
    CLASSIFICATIONS.include? @region
  end

  def valid_shape?
    @shape_group.include? @shape
  end

  def find_shape_group
    raise "Unknown region, please provide a valid region." unless valid_region?

    CLASSIFICATIONS[@region]
  end

  def find_shape
    raise "Unknown shape value." unless valid_shape?

    @shape_group[@shape]
  end

  def classify
    arrowhead = find_shape

    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.new(:northern_plains, :bifurcated).classify
