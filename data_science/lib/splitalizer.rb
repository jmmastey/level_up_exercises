require './lib/splitalizer_data_loader'
require './lib/split_data'

# Currently only for two groups or test
# I can add the ability for multiple groups
# That seemed out of scope for testing purposes
# Although this would provid more test scenarios...
class Splitalizer

	CONFIDENCE 		= 1.96
	NUM_DECIMALS	= 2
	Z_SCORE				= 3.841

	attr_accessor :a_conv_percent, :b_conv_percent,
								:a_low, :a_high,
								:b_low, :b_high,
								:a_total, :b_total, :a_num_converted,
								:b_num_converted


	def initialize(data)
		@data = data
		analyze
	end


	def winning_group

		analyze if @winning_group.nil?

		if @a_conv_percent > @b_conv_percent
			return "A"
		else
			return "B"
		end

	end

	def significant?
		chi > Z
	end

	def format(attribute)
		value = send(attribute)
		(value*100).round(NUM_DECIMALS).to_s + "%"
	end


	def chi
		return @chi_squared unless @chi_squared.nil?

		# Formula: http://math.hws.edu/javamath/ryan/ChiSquare.html
		a = @data[:a_conv].to_f
		b = @data[:a_total] - @data[:a_conv].to_f

		c = @data[:b_conv].to_f
		d = @data[:b_total] - @data[:b_conv].to_f

		numerator = (a*d - b*c)**2 * (a+b+c+d)
		denominator = (a+b)*(c+d)*(b+d)*(a+c)

		@chi_squared = numerator / denominator
	end

	private

	def analyze

		@a_conv_percent = @data[:a_conv] / @data[:a_total].to_f
		@b_conv_percent = @data[:b_conv] / @data[:b_total].to_f

		a_stdv = Math.sqrt(@a_conv_percent * (1-@a_conv_percent) / @data[:a_total])
		b_stdv = Math.sqrt(@b_conv_percent * (1-@b_conv_percent) / @data[:b_total])

		@a_low  = @a_conv_percent - CONFIDENCE * a_stdv
		@a_high = @a_conv_percent + CONFIDENCE * a_stdv

		@b_low  = @b_conv_percent - CONFIDENCE * b_stdv
		@b_high = @b_conv_percent + CONFIDENCE * b_stdv

	end




end

data = SplitalizerDataLoader.parse("./source_data.json")

splital = Splitalizer.new(data)

puts "TEST: #{splital.format(:a_low)}"
