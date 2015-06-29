class Arrowhead
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
    raise "Invalid region." unless CLASSIFICATIONS.include? region
    raise "Invalid shape value." unless shapes.include? shape

    "You have a(n) '#{CLASSIFICATIONS[region][shape]}' arrowhead."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
