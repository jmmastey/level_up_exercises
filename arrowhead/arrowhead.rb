class Arrowhead
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
    raise "Invalid region." unless CLASSIFICATIONS.include?(region)

    shapes = CLASSIFICATIONS[region]
    raise "Invalid shape." unless shapes.include?(shape)

    arrowhead = shapes[shape]

    "You have #{a_an(arrowhead)} '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.a_an(word)
    %(a e i o u).include?(word[0].downcase) ? "an" : "a"
  end
end

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
