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
    when !region_exists?(region) then region_doesnt_exist
    when !shape_exists?(shape, region) then shape_doesnt_exist
    else puts print_arrowhead(CLASSIFICATIONS[region][shape])
    end
  end

  def self.region_exists?(region)
    CLASSIFICATIONS.include? region
  end

  def self.shape_exists?(shape, region)
    CLASSIFICATIONS[region].include? shape
  end

  def self.print_arrowhead(shape)
    puts "You have a(n) '#{shape}' arrowhead. Probably priceless."
  end

  def self.shape_doesnt_exist
    raise "Unknown shape value. Are you sure you know what you're talking about?"
  end

  def self.region_doesnt_exist
    raise "Unknown region. Please provide a valid region."
  end

end

puts Arrowhead.classify(:northern_plains, :bifurcated)
