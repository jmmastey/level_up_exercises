class Arrowhead
  REGION_ERROR = 'Invalid Region Error'
  SHAPE_ERROR  = 'Invalid Shape Error'

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

  def self.raise_error(error)
    raise error
  end

  def self.raise_shape_error
    raise_error(SHAPE_ERROR)
  end

  def self.raise_region_error
    raise_error(REGION_ERROR)
  end

  def self.validate_region(region)
    raise_region_error unless CLASSIFICATIONS.include? region
  end

  def self.validate_shape(region, shape)
    validate_region(region)
    raise_shape_error unless CLASSIFICATIONS[region].include? shape
  end

  def self.find_arrowhead(region, shape)
    CLASSIFICATIONS[region][shape]
  end

  def self.print_arrowhead(arrowhead)
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.classify(region, shape)
    validate_shape(region, shape)
    arrowhead = find_arrowhead(region, shape)
    print_arrowhead(arrowhead)
  end

  private_class_method :raise_error, :raise_shape_error, :raise_region_error,
    :validate_shape, :validate_region, :find_arrowhead,
    :print_arrowhead
end

puts Arrowhead.classify(:northern_plains_dfsf, :bifurcated)
