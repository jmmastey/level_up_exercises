class Arrowhead
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

  attr_reader :region, :shape

  def self.classify(region, shape)

    @region = region
    @shape = shape

    unless valid_region?
      raise "Unknown region, please provide a valid region."
    end

    unless valid_shape?
      raise "Unknown shape value. Are you sure you know what you're talking about?"
    end

    arrowhead = CLASSIFICATIONS[region].fetch shape
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.valid_region?
    !CLASSIFICATIONS[@region].nil?
  end

  def self.valid_shape?
    CLASSIFICATIONS[@region].key? @shape
  end
end

Arrowhead::classify(:northern_plains, :lanceolate)

