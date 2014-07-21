require './splitalize_data_loader'
require './split_data'

class Splitalize

	def initialize(split_data)
		@split_data = split_data
	end

	def analyze
		puts "Let's do some data crunching..."
	end

end

data = SplitalizeDataLoader.parse("source_data.json")

splital = Splitalize.new(data)

splital.analyze()
