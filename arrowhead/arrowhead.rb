# This seriously belongs in a database.
## CSV or JSON -- overkill?
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

class Arrowhead
  def self.classify(region, shape)
    raise "Unknown region." unless CLASSIFICATIONS.include? region
    shapes = CLASSIFICATIONS[region]
    raise "Unknown shape value." unless shapes.include? shape
    "You have a(n) '#{shapes[shape]}' arrowhead.  Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
