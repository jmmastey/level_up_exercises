require 'json'

data = File.read("arrowhead_data.json")
CLASSIFICATIONS = JSON.parse(data, :symbolize_names => true)

class Arrowhead
  def self.classify(region, shape)
    unless shapes = CLASSIFICATIONS[region]
      raise "Unknown region, please provide a valid region."
    end

    unless arrowhead = shapes[shape]
      raise "Unknown shape value. Are you sure you know what you're talking about?"
    end

    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
