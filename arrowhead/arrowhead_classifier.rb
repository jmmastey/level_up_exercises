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
			collection.arrowheads.select{ |a| a.region == region && a.shape == shape}
		end

		def log_classification_results(matches)
			matches.any? ? print_success(matches) : raise_no_match_error
		end

		def print_success(matches)
			puts "Your arrowhead is the #{matches.first.name}! Probably priceless."
		end

		def raise_no_match_error
			raise "The system could not locate an arrowhead matching the specified region and shape."
		end

		def populate_collection
			collection.add(region: :far_west, shape: :notched, name: "Archaic Side Notch" )
			collection.add(region: :far_west, shape: :stemmed, name: "Archaic Stemmed" )
			collection.add(region: :far_west, shape: :lanceolate, name: "Agate Basin")
			collection.add(region: :far_west, shape: :bifurcated, name: "Cody")
			collection.add(region: :northern_plains, shape: :notched, name: "Besant" )
			collection.add(region: :northern_plains, shape: :stemmed, name: "Archaic Stemmed" )
			collection.add(region: :northern_plains, shape: :lanceolate, name: "Humbolt Constricted Base")
			collection.add(region: :northern_plains, shape: :bifurcated, name: "Oxbow")
		end
end

classifier = ArrowheadClassifier.new
classifier.classify(:far_west, :notched)
classifier.classify(:somewhere_else, :etc)

