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

  # FIXME: I don't have time to deal with this.
  def self.classify(region, shape)
      shapes = find_shapes(region)
      find_arrowhead(shapes, shape)
  end

  def self.find_shapes(region)
    if CLASSIFICATIONS.include? region
      CLASSIFICATIONS[region]
    else
      raise "Unknown region, please provide a valid region."
    end 
  end

  def self.find_arrowhead(shapes,shape)
     if shapes.include? shape
       arrowhead = shapes[shape]
       "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
     else
       raise "Unknown shape value. Are you sure you know what you're talking about?"
     end 
  end

end

puts Arrowhead.classify(:northern_plaains, :bifurcated)
