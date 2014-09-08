class Arrowhead
  # This _seriously_ belongs in a database.
  CLASSIFICATIONS = {
    far_west: {
      notched: 'Archaic Side Notch',
      stemmed: 'Archaic Stemmed',
      lanceolate: 'Agate Basin',
      bifurcated: 'Cody'
    },
    northern_plains: {
      notched: 'Besant',
      stemmed: 'Archaic Stemmed',
      lanceolate: 'Humboldt Constricted Base',
      bifurcated: 'Oxbow'
    }
  }

  def self.classify(region, shape)
    classify_shape(region, shape) if region_present?(CLASSIFICATIONS, region)
  end

  def self.classify_shape(region, shape)
    if classification_present?(CLASSIFICATIONS, region, shape)
      arrowhead = CLASSIFICATIONS[region][shape]
      puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    end
  end

  def self.region_present?(data, region)
    err_str = 'Region doesn\'t exist.'
    data.include?(region) || fail(err_str)
  end

  def self.classification_present?(data, region, shape)
    err_str = 'Classification doesn\'t exist.'
    if region_present?(data, region)
      data[region].include?(shape) || fail(err_str)
    end
  end
end

def self.classify
  arrowhead = classify(region, shape)
  puts "You have a(n) #{arrowhead} arrowhead. Probably priceless."
end
