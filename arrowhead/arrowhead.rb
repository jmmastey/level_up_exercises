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
    
    case
    when !region_exists?(region) then puts "Unknown region, please provide a valid region"
    when !shape_exists?(shape, region) then puts "Unknown shape value. Are you sure you know what you're talking about?"
    else puts "You have a(n) '#{CLASSIFICATIONS[region][shape]}' arrowhead. Probably priceless."
    end
    
  end
  
  private
  
  def self.region_exists?(region)
    CLASSIFICATIONS.include? region
  end
  
  def self.shape_exists?(shape, region)
    CLASSIFICATIONS[region].include? shape
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
