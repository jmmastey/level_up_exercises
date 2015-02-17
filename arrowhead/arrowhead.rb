# class arrowhead
class Arrowhead
  # This seriously belongs in a database.
  CLASSIFICATIONS = {
    far_west:
      {
        notched: 'Archaic Side Notch',
        stemmed: 'Archaic Stemmed',
        lanceolate: 'Agate Basin',
        bifurcated: 'Cody'
      },
    northern_plains:
      {
        notched: 'Besant',
        stemmed: 'Archaic Stemmed',
        lanceolate: 'Humboldt Constricted Base',
        bifurcated: 'Oxbow'
      }
  }

  def self.classify(region, shape)
    fail 'Unknown region, please enter valid region.' unless region?(region)
    fail 'Unknown shape, please enter valid shape.' unless shape?(region, shape)

    arrowhead = CLASSIFICATIONS[region][shape]
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.region?(region)
    CLASSIFICATIONS.include? region
  end

  def self.shape?(region, shape)
    CLASSIFICATIONS[region].include? shape
  end
end
puts Arrowhead.classify(:northern_plains, :bifurcated)
