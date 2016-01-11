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

  def self.get_regional_shapes(region)
    unless CLASSIFICATIONS.include? region
      raise "Unknown region, please provide a valid region."
    end

    CLASSIFICATIONS[region]
  end

  def self.classify(region, shape)
    shapes = get_regional_shapes(region)

    raise "Unknown shape value." unless shapes.include? shape

    "You have a(n) '#{shapes[shape]}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
