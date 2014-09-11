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

  attr_reader :region, :shape, :arrowhead_name

  def self.classify(region, shape)
    @region = region
    @shape = shape

    unless valid_region?
      fail "Unknown region, please provide a valid region."
    end

    unless valid_shape?
      fail "Unknown shape value. Are you sure you know what you're talking about?"
    end

    arrowhead_name = CLASSIFICATIONS[region].fetch shape
  end

  def self.valid_region?
    !CLASSIFICATIONS[@region].nil?
  end

  def self.valid_shape?
    CLASSIFICATIONS[@region].key? @shape
  end

  def to_s
    "You have a(n) '#{arrowhead_name}' arrowhead. Probably priceless."
  end
end

