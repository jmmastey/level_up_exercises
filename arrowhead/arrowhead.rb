class Arrowhead
  UNKNOWN_REGION = 'Unknown region, please provide a valid region.'
  UNKNOWN_SHAPE  = "Unknown shape value."\
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
    arwhead = region_shapes.nil? ? raise(UNKNOWN_REGION) : region_shapes[shape]
    arwhead.nil? ? raise(UNKNOWN_SHAPE) : arrowhead_msg(arwhead)
  end

  def self.arrowhead_msg(arrowhead)
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
