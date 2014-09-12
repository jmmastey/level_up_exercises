# arrowhead/arrowhead.rb
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
    begin
      arrowhead = get_arrowhead(get_shapes(region), shape)
      puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    rescue KeyError
      raise "Unknown. Are you sure you know what you're talking about?"

    end
  end

  def self.get_arrowhead(shapes, shape)
    shapes.fetch(shape)

  end

  def self.get_shapes(region)
    CLASSIFICATIONS.fetch(region)
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
