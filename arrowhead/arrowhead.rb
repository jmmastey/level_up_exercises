class Arrowhead
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

  UNKNOWN_REGION = "Unknown region, please provide a valid region."
  UNKNOWN_SHAPE = "Unknown shape value.Are you sure you know
                  what you're talking about?"

  def self.classify(region, shape)
    raise UNKNOWN_REGION unless CLASSIFICATIONS.include? region
    raise UNKNOWN_SHAPE unless CLASSIFICATIONS[region].include? shape
    arrowhead = CLASSIFICATIONS[region][shape]
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
# puts Arrowhead.classify(:abc, :bifurcated)
# puts Arrowhead.classify(:northern_plains, :abc)
