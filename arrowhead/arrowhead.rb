class Arrowhead
  # This seriously belongs in a database.
  CLASSIFICATIONS = {
    far_west: {
      notched: "Archaic Side Notch",
      stemmed: "Archaic Stemmed",
      lanceolate: "Agate Basin",
      bifurcated: "Cody"
    },
    northern_plains: {
      notched: "Besant",
      stemmed: "Archaic Stemmed",
      lanceolate: "Humboldt Constricted Base",
      bifurcated: "Oxbow"
    }
  }

  def self.classify(region, shape)
    validate_input(CLASSIFICATIONS, region, "region")
    validate_input(CLASSIFICATIONS[region], shape, "shape in region #{region}")

    arrowhead = CLASSIFICATIONS[region][shape]
    puts "You have a(n) #{arrowhead} arrowhead. Probably priceless."
  end

  def self.validate_input(map, value, name)
    map.include?(value) || raise(ArgumentError, "Unknown #{name} #{value}")
  end
end

inputs = [
  [:northern_plains, :bifurcated],
  [:far_west, :lanceolate],
  [:northern_plains, :lanceolate],
  [:northern_plains, :asdf],
  [:hello, :bifurcated]
]

inputs.each do |region_and_shape|
  begin
    Arrowhead.classify(region_and_shape[0], region_and_shape[1])
  rescue ArgumentError => ae
    puts "Argument error: #{ae.message}"
  end
end
