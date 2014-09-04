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
     get_arrowhead(get_shapes(region), shape)
  end

  private
  def self.get_arrowhead(shapes, shape)
    begin
      arrowhead = shapes[shape]
      puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    rescue
      raise "Unknown shape value. Are you sure you know what you're talking about?"
    end
  end

  def self.get_shapes(region)
    begin
    CLASSIFICATIONS[region]
    rescue
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
