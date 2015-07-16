class Arrowhead
  # This seriously belongs in a database.
  CLASSIFICATIONS = {
    far_west: {
      notched: "Archaic Side Notch",
      stemmed: "Archaic Stemmed",
      lanceolate: "Agate Basin",
      bifurcated: "Cody"
    },
    northern_plains: {
      notched: "Besant",
      stemmed: "Archaic Stemmed",
      lanceolate: "Humboldt Constricted Base",
      bifurcated: "Oxbow"
    }
  }

  def self.classify(region, shape)
    unless CLASSIFICATIONS.include? region
      raise "Unknown region, please provide a valid region."
    end    
    
    shapes = CLASSIFICATIONS[region]

    unless shapes.include? shape
      raise "Unknown shape value. Are you sure you know what you're talking
             about?"
    end

    arrowhead = shapes[shape]
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
