class Arrowhead
  # This seriously belongs in a database.
  CLASSIFICATIONS = {
    far_west: {
      notched: 'Archaic Side Notch',
      stemmed: 'Archaic Stemmed',
      lanceolate: 'Agate Basin',
      bifurcated: 'Cody',
    },
    northern_plains: {
      notched: 'Besant',
      stemmed: 'Archaic Stemmed',
      lanceolate: 'Humboldt Constricted Base',
      bifurcated: 'Oxbow',
    },
  }

  def self.classify(region, shape)
    unless CLASSIFICATIONS.include? region
      raise 'Unknown region, please provide a valid region.'
    end
    classify_shape_for_specific_region region, shape
  end

  private_class_method :new
  def self.classify_shape_for_specific_region(region, shape)
    shapes = CLASSIFICATIONS[region]
    unless shapes.include? shape
      raise 'Unknown shape value.' \
      " Are you sure you know what you're talking about?"
    end
    "You have a(n) '#{shapes[shape]}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
