class InvalidRegionError<StandardError;end
class InvalidShapeError<StandardError;end

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


  def self.classify(region, shape)
    if CLASSIFICATIONS.include?(region)==false
      #raise "Not valid region"
      raise InvalidRegionError.new
    elsif CLASSIFICATIONS.include?(region)==true
       shapes = CLASSIFICATIONS[region]
       if shapes.include?(shape)==true
          arrowhead = shapes[shape]
          puts "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
       elsif shapes.include?(shape)==false
          #raise "Not a valid shape"
          raise InvalidShapeError
      end
    end
 end
end

begin
  puts Arrowhead.classify(:northern_plains, :bifurcated)
rescue InvalidRegionError
  puts "Not a valid region"
rescue InvalidShapeError
  puts "Not a valid shape"
end

