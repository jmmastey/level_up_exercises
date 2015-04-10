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

    return 'Unknown region.' if not CLASSIFICATIONS.include?(region)
    shapes = CLASSIFICATIONS[region]
    return 'Unknown shape.' if not shapes.include?(shape)
    arrowhead = shapes[shape]
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:far_west, :bisurcated)
puts Arrowhead.classify(:far_east, :notched)
puts Arrowhead.classify(:far_west, :bifurcated)
