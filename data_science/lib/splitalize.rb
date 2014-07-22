require './lib/splitalize_data_loader'
require './lib/split_data'

# Currently only for two groups or test
# I can add the ability for multiple groups
# That seemed out of scope for testing purposes
class Splitalize

	def initialize(data, test_name = "A/B Split Test")
		@data = data
		@test_name = test_name
	end

	def analyze

		confidence = 1.96

		ap = @data[:a_conv] / @data[:a_total].to_f
		bp = @data[:b_conv] / @data[:b_total].to_f

		a_stdv = Math.sqrt(ap * (1-ap)/@data[:a_total])
		b_stdv = Math.sqrt(bp * (1-bp)/@data[:b_total])



		a_low = ap - confidence * a_stdv
		a_high = ap + confidence * a_stdv

		b_low = bp - confidence * b_stdv
		b_high = bp + confidence * b_stdv

		puts "A: " + format(ap) + " (#{format(a_low)}-#{format(a_high)})"

		puts "B: " + format(bp) + " (#{format(b_low)}-#{format(b_high)})"




	end

	private

	def format(dec_value, decimals = 2)
		(dec_value*100).round(decimals).to_s + "%"
	end

end

data = SplitalizeDataLoader.parse("./source_data.json")

splital = Splitalize.new(data)

splital.analyze()
