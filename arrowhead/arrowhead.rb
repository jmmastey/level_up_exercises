class Arrowhead
  UNKNOWN_REGION = "Unknown region, please provide a valid region."
  UNKNOWN_SHAPE = "Unknown shape value. " \
                  "Are you sure you know what you're talking about?"

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
    shapes = shapes_by_region(region)
    raise UNKNOWN_SHAPE unless shapes.include? shape

    arrowhead = shapes[shape]
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.shapes_by_region(region)
    raise UNKNOWN_REGION unless CLASSIFICATIONS.include? region

    CLASSIFICATIONS[region]
  end
end

test_data = [{ region: :northern_plains, shape: :bifurcated },
             { region: :foo, shape: :bifurcated },
             { region: :northern_plains, shape: :foo }]
test_data.each do |data|
  begin
    puts Arrowhead.classify(data[:region], data[:shape])
  rescue StandardError => e
    puts e.message
  end
end
