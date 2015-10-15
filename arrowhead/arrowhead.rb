class Arrowhead
  # TODO: Move this to a database.
  CLASSIFICATIONS = {
    far_west:        {
      notched:    'Archaic Side Notch',
      stemmed:    'Archaic Stemmed',
      lanceolate: 'Agate Basin',
      bifurcated: 'Cody',
    },
    northern_plains: {
      notched:    'Besant',
      stemmed:    'Archaic Stemmed',
      lanceolate: 'Humboldt Constricted Base',
      bifurcated: 'Oxbow',
    },
  }

  private_constant :CLASSIFICATIONS

  def self.classify(region, shape)
    raise "Unknown region #{region}, please provide a valid region." unless CLASSIFICATIONS.include?(region)

    shapes = CLASSIFICATIONS[region]
    raise "Unknown shape #{shape}, please provide a valid shape." unless shapes.include?(shape)

    arrowhead = shapes[shape]
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
