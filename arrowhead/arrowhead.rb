# Classify arrowheads based on region and shape
class Arrowhead
  # This seriously belongs in a database.
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

  # FIXME: I don't have time to deal with this.
  def self.classify(region, shape)
    if CLASSIFICATIONS.include? region
      shapes = CLASSIFICATIONS[region]
      print_choice shapes, shape
    else
      fail 'Unknown region, please provide a valid region.'
    end
  end

  def self.print_choice(p_region, p_shape)
    if p_region.include? p_shape
      puts "You have a(n) #{p_region[p_shape]} arrowhead, probably priceless."
    else
      fail "Unknown shape. Are you sure you know what you're talking about?"
    end
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
