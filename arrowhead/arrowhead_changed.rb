require 'pry'
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
      puts region_present?(region)
      #if region_present?(region) && shape_present?(region, shape)
      raise "Unknown region, please provide a valid region" unless region_present?(region)
      raise "Unknown shape value. Are you sure you what you're  talking about?" unless shape_present?(region, shape)

      arrowhead = CLASSIFICATIONS[region][shape]
      puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
      #end
  end



  def self.region_present?(region)
    CLASSIFICATIONS.include?(region)
    #CLASSIFICATIONS.include?region || (raise "Unknown region, please provide a valid region")
  end   

  def self.shape_present?(region, shape)
    CLASSIFICATIONS[region].has_key?(shape)
    #CLASSIFICATIONS[region].has_key?(shape) || (raise "Unknown shape value. Are you sure you what you're  talking about?")
  end      

end



puts Arrowhead::classify(:northern_plains, :bifurcated)
