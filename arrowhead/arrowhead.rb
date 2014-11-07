class Arrowhead
  # This seriously belongs in a database
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
    error1 =  "Unknown region, please provide a valid region."
    raise error1 unless CLASSIFICATIONS.include? region
    output_arrow(region, shape)
  end

  def self.output_arrow(arrow_region, arrow_shape)
    shapes = CLASSIFICATIONS[arrow_region]
    error2 = "Unknown shape. Are you sure you know what you're talking about?"
    raise error2 unless shapes.include?(arrow_shape)
    puts "You have a(n) '#{shapes[arrow_shape]}' arrowhead, probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
