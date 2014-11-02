class InvalidRegionError < StandardError; end
class InvalidShapeError < StandardError; end

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
    if check_region(region) == true
      shapes = CLASSIFICATIONS[region]
      if check_shape(shape, shapes) == true
        arrowhead = shapes[shape]
        puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
      end
    end
  end

  def self.check_region(region)
    if CLASSIFICATIONS.include?(region) == false
      raise InvalidRegionError, 'Not a Valid region'
    end
    true
  end

  def self.check_shape(shape, shapes)
    if shapes.include?(shape) == false
      raise InvalidShapeError, "Not a Valid shape"
    end
    true
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
