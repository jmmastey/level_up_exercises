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

  def self.region_lookup(region)
    unless CLASSIFICATIONS.include? region
      raise "Unknown region, please provide a valid region."
    end
    CLASSIFICATIONS[region]
  end

  def self.shape_lookup(region_info, shape)
    unless region_info.include? shape
      error_msg = "Unkonwn shape value. Are you sure you know what"
      error_msg = error_msg << " you are talking about?"
      raise error_msg
    end
    region_info[shape]
  end

  def self.classify(region, shape)
    region_info = region_lookup(region)
    arrowhead_info = shape_lookup(region_info, shape)
    "You have a(n) '#{arrowhead_info}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
puts Arrowhead.classify(:far_west, :lanceolate)
puts Arrowhead.classify(:far_west, :pretty)
