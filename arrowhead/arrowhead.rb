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

  ERR = {
    region: "Unknown region, please provide a valid region.",
    shape: "Unknown shape value. "\
           "Are you sure you know what you're talking about?",
  }

  def self.classify(region, shape)
    raise ERR[:region] if CLASSIFICATIONS[region].nil?
    shape = CLASSIFICATIONS[region][shape]
    raise ERR[:shape] if shape.nil?

    puts "You have a(n) '#{shape}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
