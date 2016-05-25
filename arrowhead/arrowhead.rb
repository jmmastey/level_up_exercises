require_relative 'classifications'

class Arrowhead

  def self.classify_region(region, shape)
    if Classifications::CLASSIFICATIONS.include? region
      self.classify_arrow(region, shape)
    else
      raise "Unknown region, please provide a valid region."
    end
  end

  def self.classify_arrow(region, shape)
    shapes = Classifications::CLASSIFICATIONS[region]

    if shapes.include? shape
      arrowhead = shapes[shape]
      "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
    else
      raise "Unknown shape value. Are you sure you know what you're talking about?"
    end
  end

end

