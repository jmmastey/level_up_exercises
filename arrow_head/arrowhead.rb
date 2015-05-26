require_relative 'classifications.rb'
require_relative 'exceptions.rb'
# This is the main class for the exercise
# This class is used to define errors
class UnknownRegionError < RuntimeError
 def message
   'Unknown region, please provide a valid region.'
 end
end

class UnknownShapeError < RuntimeError
  def message
    "Unknown shape value. Are you sure you know what you're talking about?"
  end
end

class Arrowhead
  @classify_class = Classify.new
  @my_classify =   Classify::CLASSIFICATIONS

  # FIXME: I don't have time to deal with this.
  def self.classify(region, shape)
    @classify_class.get_shapes(@my_classify, region, shape)
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
