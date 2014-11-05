# Classify arrowheads based on region and shape
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

  # FIXME: I don't have time to deal with this.
  def self.classify(region, shape)
    if CLASSIFICATIONS.include? region
      output_arrw region, shape
    else
      raise "Unknown region, please provide a valid region."
    end
  end

  def self.output_arrw(arrw_region, arr_shape)
    shapes = CLASSIFICATIONS[arrw_region]
    if shapes.include? arr_shape
      puts "You have a(n) '#{shapes[arr_shape]}' arrowhead, probably priceless."
    else
      raise "Unknown shape. Are you sure you know what you're talking about?"
    end
  end
end

puts Arrowhead.classify(:far_west, :bifurcated)
