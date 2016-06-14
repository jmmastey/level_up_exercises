require 'json'

class Arrowhead
  REGION_ERROR = "Unknown region, please provide a valid region.".freeze
  SHAPE_ERROR =  "Unknown shape value. Are you sure you know what
  you're talking about?".freeze
  CLASSIFICATIONS = JSON.parse(File.read("arrowhead/database.json"))

  def self.classify(region, shape)
    raise REGION_ERROR unless CLASSIFICATIONS.include?(region)

    shapes = CLASSIFICATIONS[region]
    raise SHAPE_ERROR unless shapes.include?(shape)

    arrowhead = shapes[shape]
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify('northern_plains', 'bifurcated')
