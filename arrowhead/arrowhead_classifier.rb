require_relative "arrowhead_collection"

class ArrowheadClassifier
  attr_accessor :collection

  def initialize
    @collection = ArrowheadCollection.new
    populate_collection
  end

  def classify(region, shape)
    matches = classification_matches(region, shape)
    log_classification_results(matches)
  end

  private

  def classification_matches(region, shape)
    collection.arrowheads.select do |a|
      a.region == region && a.shape == shape
    end
  end

  def log_classification_results(matches)
    if matches.any?
      print_success(matches)
    else
      error_msg = "The system could not locate an arrowhead matching the"
      error_msg += " specified region and shape."
      raise error_msg
    end
  end

  def print_success(matches)
    puts "Your arrowhead is the #{matches.first.name}! Probably priceless."
  end

  def populate_collection
    collection.add(region: :far_west,
                   shape: :notched,
                   name: "Archaic Side Notch")
    collection.add(region: :far_west,
                   shape: :stemmed,
                   name: "Archaic Stemmed")
    collection.add(region: :far_west,
                   shape: :lanceolate,
                   name: "Agate Basin")
    collection.add(region: :far_west,
                   shape: :bifurcated,
                   name: "Cody")
    collection.add(region: :northern_plains,
                   shape: :notched,
                   name: "Besant")
    collection.add(region: :northern_plains,
                   shape: :stemmed,
                   name: "Archaic Stemmed")
    collection.add(region: :northern_plains,
                   shape: :lanceolate,
                   name: "Humbolt Constricted Base")
    collection.add(region: :northern_plains,
                   shape: :bifurcated,
                   name: "Oxbow")
  end
end

classifier = ArrowheadClassifier.new
classifier.classify(:far_west, :notched)
classifier.classify(:somewhere_else, :etc)
