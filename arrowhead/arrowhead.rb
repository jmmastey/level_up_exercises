module DataStore

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

end


class Arrowhead

  def self.classify(region, shape)
    if !valid_region?(region)
        raise "Unknown region, please provide a valid region."
    end


    valid_shapes = get_shapes(region)


    if !valid_shape?(valid_shapes, shape)
      raise "Unknown shape value. Are you sure you know what you're talking about?"
    end

    arrowhead = valid_shapes[shape]

    puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."


  end

  private

  def self.get_shapes(region)
    DataStore::CLASSIFICATIONS[region]
  end


  # private :valid_region?, :valid_shape?

  def self.valid_region?(region)
    DataStore::CLASSIFICATIONS.include?(region)
  end

  def self.valid_shape?(valid_shapes, shape)
    valid_shapes.include?(shape)
  end


end


puts Arrowhead::classify(:northern_plains, :bifurcated)
puts Arrowhead::classify(:far_west, :bifurcated)
puts Arrowhead::classify(:foo, :bifurcated)
puts Arrowhead::classify(:northern_plains, :foo)
puts Arrowhead::classify(:northern_plains, :lanceolate)
