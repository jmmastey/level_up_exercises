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

  def self.classify_region(region)
    raise "Unknown region, please provide a valid region." unless
    CLASSIFICATIONS.include? region
    CLASSIFICATIONS[region]
  end

  def self.classify_shape(region, shape)
    if classify_region(region).include? shape
      puts "You have a(n) '#{classify_region(region)[shape]}' arrowhead.\
      Probably priceless."
    else
      raise "Unknown shape value.\
      Are you sure you know what you're talking about?"
    end
  end
end

puts Arrowhead.classify_shape(:northern_plains, :bifurcated)
