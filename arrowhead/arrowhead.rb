require 'json'

class Arrowhead
  File.open('classifications.json', 'r') do |f|
    CLASSIFICATIONS = JSON.load(f)
  end

  def self.classify(region, shape)
    shapes = region_shapes(region.to_s)
    puts arrowhead(shapes, shape.to_s)
  end

  def self.region_shapes(region)
    e = "Unknown region, please provide a valid region."
    raise e unless CLASSIFICATIONS.include? region
    CLASSIFICATIONS[region]
  end

  def self.arrowhead(shapes, shape)
    e = "Unknown shape value. Are you sure you know what you're talking about?"
    raise e unless shapes.include? shape
    "You have a(n) '#{shapes[shape]}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
