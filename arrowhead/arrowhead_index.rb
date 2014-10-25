require_relative 'arrowhead'

# Queryable container class that contains custom arrohead information.
class ArrowheadIndex
  attr_reader :arrowheads

  def initialize(arrowheads = [])
    @arrowheads = arrowheads
  end

  def region(region)
    filter('Unknown region, Please provide a valid region.') do
      | arrowhead | arrowhead.region == region
    end
  end

  def shape(shape)
    filter('Unknown shape. Please provide a valid shape.') do
      | arrowhead | arrowhead.shape == shape
    end
  end

  private def filter(error_msg, &block)
    result = @arrowheads.select(&block)
    fail error_msg if result.empty?
    ArrowheadIndex.new(result)
  end
end

arrowheads = [
  Arrowhead.new(:far_west, :notched, 'Archaic Side Notch'),
  Arrowhead.new(:far_west, :stemmed, 'Archaic Stemmed'),
  Arrowhead.new(:far_west, :lanceolate, 'Agate Basin'),
  Arrowhead.new(:far_west, :bifurcated, 'Cody'),
  Arrowhead.new(:northern_plains, :notched, 'Besant'),
  Arrowhead.new(:northern_plains, :stemmed, 'Archaic Stemmed'),
  Arrowhead.new(:northern_plains, :lanceolate, 'Humboldt Constricted Base'),
  Arrowhead.new(:northern_plains, :bifurcated, 'Oxbow')
]

index = ArrowheadIndex.new(arrowheads)
filtered_index = index.region(:northern_plains).shape(:bifurcated)
puts filtered_index.arrowheads
