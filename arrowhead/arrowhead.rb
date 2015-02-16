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

  def self.exists_region?(region)
    CLASSIFICATIONS.include? region
  end

  def self.exists_shape?(region, shape)
    CLASSIFICATIONS[region].include? shape
  end

  def self.classify(region, shape)
    unless exists_region? region
      raise "Unknown region, please provide a valid region."
    end
    unless exists_shape?(region, shape)
      raise "Unknown shape value. Are you sure you know what you're "
        +"talking about?"
    end
    puts "You have a(n) '#{CLASSIFICATIONS[region][shape]}' arrowhead. "
      +"Probably priceless."
  end

end

puts Arrowhead.classify(:northern_plains, :bifurcated)

