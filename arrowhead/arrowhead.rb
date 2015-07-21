class Arrowhead
  UNKNOWN_REGION_MSG = 'Unknown region, please provide a valid region.'
  UNKNOWN_SHAPE_MSG  = "Unknown shape value."\
                       "Are you sure you know what you're talking about?"

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
  def self.classify(region, shape)
    region_shapes = CLASSIFICATIONS[region]
    arrowhead = region_shapes.nil? ? raise(UNKNOWN_REGION_MSG) : region_shapes[shape]
    arrowhead.nil? ? raise(UNKNOWN_SHAPE_MSG) : arrowhead_msg(arrowhead)
  end

  def self.arrowhead_msg(arrowhead)
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
