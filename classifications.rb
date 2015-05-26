require_relative 'exceptions.rb'
# This class is used to define classfications
class Classify
  REGION_ERROR = 'Unknown region, please provide a valid region.'
  UNKNOWN_SHAPE = "Unknown shape value.
   Are you sure you know what you're talking about?"

  # FIXME: I don't have time to deal with this.
  def get_shapes(classifications, region, shape)
    shapes = classifications[region] if classifications.include? region
    raise UnknownRegionError,
          REGION_ERROR unless classifications.include? region
    get_arrowhead(shapes, shape) if shapes
  end

  def get_arrowhead(shapes, shape)
    arrowhead = shapes[shape] if shapes.include? shape
    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless." if shapes.include? shape
    raise UnknownShapeError, UNKNOWN_SHAPE unless shapes.include? shape
  end
end
