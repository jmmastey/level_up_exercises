class Arrowhead
  # This seriously belongs in a database.
  UNKNOWN_REG_MSG =  "Unknown region, please provide a valid region."
  UNKNOWN_SHAPE_MSG = 'Unknown shape value.' \
  'Are you sure you know what you\'re talking about?'

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
    raise UNKNOWN_REG_MSG unless CLASSIFICATIONS.include? region
    raise UNKNOWN_SHAPE_MSG unless CLASSIFICATIONS[region].include? shape
    arrowhead = CLASSIFICATIONS[region][shape]
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless." if arrowhead
    rescue StandardError => e
      print e
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
puts Arrowhead.classify(:far_west, :wrong)
puts Arrowhead.classify(:far_west, :lanceolate)
puts Arrowhead.classify(:wrong, :notched)
puts Arrowhead.classify(:norther_plains, :stemmed)
