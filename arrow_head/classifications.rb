
# This class is used to define classfications
class Classify
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
  def get_shapes(classifications, region, shape)
    classifications.include? region or raise UnknownRegionError
    shapes = classifications[region]
    get_arrowhead(shapes, shape) if shapes
  end

  def get_arrowhead(shapes, shape)
    arrowhead = shapes[shape] or raise UnknownShapeError
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end
