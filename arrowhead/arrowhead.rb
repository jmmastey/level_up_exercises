require 'json'

data = File.read("arrowhead_data.json")
CLASSIFICATIONS = JSON.parse(data, symbolize_names: true)

class Arrowhead
  REGION_ERROR = "Unknown region, please provide a valid region."
  SHAPE_ERROR  = "Unknown shape value. "\
                 "Are you sure you know what you're talking about?"

  def self.classify(region, shape)
    raise REGION_ERROR unless (shapes = CLASSIFICATIONS[region])
    raise SHAPE_ERROR  unless (arrowhead = shapes[shape])

    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
