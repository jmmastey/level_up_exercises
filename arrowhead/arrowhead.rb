require_relative 'classifications'

class Arrowhead

  def self.classify(region, shape)
    if Classifications::CLASSIFICATIONS.include? region
      shapes = Classifications::CLASSIFICATIONS[region]
      if shapes.include? shape
        arrowhead = shapes[shape]
        "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
      else
        raise "Unknown shape value. Are you sure you know what you're talking about?"
      end
    else
      raise "Unknown region, please provide a valid region."
    end
  end

end

