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
    if CLASSIFICATIONS[region]
      shapes = CLASSIFICATIONS[region]
      return "You have a(n) '#{shapes[shape]}' arrowhead. Probably priceless." if shapes[shape]
      raise "Unknown shape value. Are you sure you know what you're talking about?"
    else
      raise "Unknown region, please provide a valid region."
    end
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)

# Nonexistent region
# puts Arrowhead.classify(:tundra, :bifurcated)

# Nonexistent shape
# puts Arrowhead.classify(:far_west, :stoney)
