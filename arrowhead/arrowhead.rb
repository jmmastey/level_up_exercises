module Arrowhead
  module_function

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

  def classify(region, shape)
    region_info = region_lookup(region)
    arrowhead_info = shape_lookup(region_info, shape)
    "You have a(n) '#{arrowhead_info}' arrowhead. Probably priceless."
  end

  def region_lookup(region)
    return CLASSIFICATIONS[region] if CLASSIFICATIONS.include? region
    raise "Unknown region, please provide a valid region."
  end

  def shape_lookup(region_info, shape)
    return region_info[shape] if region_info.include? shape
    raise "Unknown shape value. Are you sure you know what you are "  \
  "talking about?"
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
puts Arrowhead.classify(:far_west, :lanceolate)
puts Arrowhead.classify(:far_west, :pretty)
