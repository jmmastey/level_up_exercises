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
    if CLASSIFICATIONS.include? region
      shapes = CLASSIFICATIONS[region]
      if shapes.include? shape
        arrowhead = shapes[shape]
        puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
      else
        raise "Unknown shape value. Are you sure you know what you're talking about?"
      end
    else
      raise "Unknown region, please provide a valid region."
    end
  end

end


def self.classify
  raise 'Region doesn\'t exist' unless self.region_present?(region)
  raise "Classification doesn't exist" unless self.classication_present?

  arrowhead = CLASSFICATIONS[region][shape]
  puts "You have a(n) #{arrowhead} arrowhead. Probably priceless."
end

def self.region_present?(region)
  CLASSIFICATIONS.include? region
end


puts Arrowhead::classify(:northern_plains, :bifurcated)
