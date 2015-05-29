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

    shapes = CLASSIFICATIONS[region]
    regions = CLASSIFICATIONS
    raise "Unknown shape value. Are you sure you know /
            what you're talking about?" unless shapes.include?(shape)
    raise  "Unknown region, please provide a /
                         valid region." unless regions.include?(region)
    arrowhead = shapes[shape]
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
puts Arrowhead.classify(:northern_plains, :bifurcated)
#puts Arrowhead.classify(:southern_plains, :bifurcated)
#puts Arrowhead.classify(:northern_plains, :oblong)
puts Arrowhead.classify(:northern_plains, :bifurcated)
puts Arrowhead.classify(:northern_plains, :bifurcated)
puts Arrowhead.classify(:northern_plains, :notched)
puts Arrowhead.classify(:northern_plains, :lanceolate)

