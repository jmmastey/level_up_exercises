# Let me try to understand what the code is doing here:
  # This is a class used to take input and return information that belongs to the input
  # There is a constant with 2 types of region, each region has 4 shapes
# I will refactor this by creating base cases that return text if conditions are not met

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

  def self.classify(region, shape)
    raise "Unknown region, please provide a valid region." unless CLASSIFICATIONS.include?(region)

    shapes = CLASSIFICATIONS[region]

    raise "Unknown shape value. Are you sure you know what you're talking about?" unless shapes.include?(shape)

    return "You have a(n) '#{shapes[shape]}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
