require_relative 'Arrowhead'

# Custom exception class for an emoty container
class EmptyContainerError < RuntimeError; end

# Queryable container class that contains custom arrohead information.
class ArrowheadIndex
  attr_reader :arrowheads

  def initialize(arrowheads = [])
    @arrowheads = arrowheads
  end

  def region(region)
    filter { | arrowhead | arrowhead.region == region }
      rescue EmptyContainerError
        raise 'Unknown region, please provide a valid region'
  end

  def shape(shape)
    filter { | arrowhead | arrowhead.shape == shape }
    rescue EmptyContainerError
      raise 'Unknown shape value.  Are you sure you know what you
           are talking about?'
  end

  private def filter(&block)
    result = @arrowheads.select(&block)
    fail EmptyContainerError if result.empty?
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
