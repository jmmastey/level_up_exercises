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

  def self.identify_shape(collection, shape)
    if collection.include? shape
      arrowhead = collection[shape]
      puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    else
      raise "Unknown shape value. Are you sure you know what you're talking about?"
    end
  end

  def self.classify(region, shape)
    if CLASSIFICATIONS.include? region
      identify_shape(CLASSIFICATIONS[region], shape)
    else
      raise "Unknown region, please provide a valid region."
    end
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
