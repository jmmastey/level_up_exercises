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

  def self.classify(region, shape)
    shapes    = find_shapes_by_region(region)    
    arrowhead = find_arrowhead_by_shape(shapes, shape)
    
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
  

private
  
  def self.find_arrowhead_by_shape(shapes, shape)
    shapes.fetch(shape)
  rescue KeyError
    raise "Unknown shape value. Are you sure you know what you're talking about?"
  end
  
  def self.find_shapes_by_region(region)
    CLASSIFICATIONS.fetch(region)
  rescue KeyError
    raise "Unknown region, please provide a valid region." 
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
