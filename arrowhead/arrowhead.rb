class Arrowhead
  # This seriously belongs in a database.
  REGION = 'Unknown region. Please provide a valid region.'
  SHAPE = "Unknown shape. Are you sure you know what you're talking about?"
  
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
    raise REGION unless CLASSIFICATIONS.include? region
    raise SHAPE unless CLASSIFICATIONS[region].include? shape
    arrowhead = CLASSIFICATIONS[region][shape]
    puts "You have a(n) '#{arrowhead}' arrowhead, probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
