class Arrowhead

  # This seriously belongs in a database.
  CLASSIFICATIONS = {
    far_west: {
      notched:    "Archaic Side Notch",
      stemmed:    "Archaic Stemmed",
      lanceolate: "Agate Basin",
      bifurcated: "Cody",
    },
    northern_plains: {
      notched:    "Besant",
      stemmed:    "Archaic Stemmed",
      lanceolate: "Humboldt Constricted Base",
      bifurcated: "Oxbow",
    },
  }
  
  @shapes = {}
  @arrowhead = ""
  def self.classify(region, shape)     
  region_error unless  valid_region?(region) 
  shape_error  unless valid_shape?(shape)   
    "You have a(n) '#{@arrowhead}' arrowhead. Probably priceless." 
  end
  
  def self.valid_region?(region)
   @shapes = CLASSIFICATIONS[region]   
  end

  def self.valid_shape?(shape)
   @arrowhead = @shapes[shape]   
  end

 def shape_error
  raise "Unknown shape value. Are you sure you know what you're talking about?" 
 end

 def region_error
  raise "Unknown region, please provide a valid region." 
 end

end


puts Arrowhead.classify(:northern_plains, :bifurcated)

