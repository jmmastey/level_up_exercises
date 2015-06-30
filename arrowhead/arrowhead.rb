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
    shapes = get_if_included(:region, region, CLASSIFICATIONS)
    arrowhead = get_if_included(:shape, shape, shapes)
    "You have a(n) '#{arrowhead}' arrowhead. Probably priceless."
  end

  def self.get_if_included(category, key, collection)
    unless collection.include? key
      raise "Unknown #{category}.  Please provide a valid #{category}."
    end
    collection[key]
  end
end

puts Arrowhead.classify(:northern_plains, :bifurcated)
