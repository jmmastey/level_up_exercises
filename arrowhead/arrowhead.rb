class Arrowhead
  # This seriously belongs in a database.
  CLASSIFICATIONS = {
    far_west: {
      notched: "Archaic Side Notch",
      stemmed: "Archaic Stemmed",
      lanceolate: "Agate Basin",
      bifurcated: "Cody",
    },
    northern_plains: {
      notched: "Besant",
      stemmed: "Archaic Stemmed",
      lanceolate: "Humboldt Constricted Base",
      bifurcated: "Oxbow",
    },
  }

  attr_accessor :region, :shape

  def initialize(region, shape)
    @region = region
    @shape = shape
    raise error_message unless valid?
  end

  def error_message
      if !CLASSIFICATIONS[@region]
        @error_message ||= "Unknown region, please provide a valid region."
      elsif !CLASSIFICATIONS[@region][@shape]
        @error_message ||= "Unknown shape value. Are you sure you know what you're talking about?"
      end
  end

  def valid?
    !error_message
  end

  def classification
    @classification ||= CLASSIFICATIONS[region] && CLASSIFICATIONS[region][shape]
  end

  def classify
    puts "You have a(n) #{classification} arrowhead. Probably priceless."
  end
end

puts Arrowhead.new(:northern_plains, :bifurcated).classify
#puts Arrowhead.new(nil, :bifurcated).classify
#puts Arrowhead.new(:northern_plains, nil).classify
