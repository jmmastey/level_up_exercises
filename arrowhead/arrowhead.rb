# Public: Classifies an arrowhead based on criteria such as region and shape
#
# Examples
#
#   Arrowhead.classify(:far_west, :notched)
#   # => "You have an 'Archaic Side Notch' arrowhead. Probably priceless."
#
#   Arrowhead.classify(:northern_plains, :lanceolate)
#   # => "You have a 'Humbolt Constricted Base' arrowhead. Probably priceless."
class Arrowhead
  # Public: Static classification table. Consider migrating to database.
  CLASSIFICATIONS = {
    :far_west => {
      :notched    => "Archaic Side Notch",
      :stemmed    => "Archaic Stemmed",
      :lanceolate => "Agate Basin",
      :bifurcated => "Cody",
    },
    :northern_plains => {
      :notched    => "Besant",
      :stemmed    => "Archaic Stemmed",
      :lanceolate => "Humboldt Constricted Base",
      :bifurcated => "Oxbow",
    },
  }

  # Public: Locates an arrowhead classification based on the provided criteria
  #
  # region - The general region in which the arrowhead was found, as a Symbol
  # shape  - The shape of the arrowhead as a Symbol
  #
  # Examples
  #
  #   classify(:northern_plains, :notched)
  #   # => "You have a 'Besant' arrowhead. Probably priceless."
  #
  # Returns a String describing the arrowhead
  # Raises an Exception if the region is not in the classification table
  # Raises an Exception if the shape is not in the classification table
  def self.classify(region, shape)
    unless CLASSIFICATIONS.include? region
      raise "Unknown region, please provide a valid region."
    end

    shapes = CLASSIFICATIONS[region]

    unless shapes.include? shape
      raise "Unknown shape value. " \
            "Are you sure you know what you're talking about?"
    end

    arrowhead = shapes[shape]
    a_an = %(a e i o u).include?(arrowhead[0].downcase) ? "an" : "a"

    "You have #{a_an} '#{arrowhead}' arrowhead. Probably priceless."
  end
end

# Demonstrates the use of the class
puts ""
puts "****************************"
puts "* Arrowhead Classification *"
puts "****************************"
puts ""

puts "Region: Northern Plains"
puts "Shape:  Bifurcated"
puts Arrowhead.classify(:northern_plains, :bifurcated)
puts ""

puts "Region: Far West"
puts "Shape:  Bifurcated"
puts Arrowhead.classify(:far_west, :bifurcated)
puts ""
