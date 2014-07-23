require './lib/splitalizer_data_loader'
require 'hirb'

# Currently only for two groups or tests
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

	def pretty_print

		a_win = ""
		b_win = ""

		if winning_group == "A"
			a_win = "*"
		else
			b_win = "*"
		end

		display_array = []

		display_array << [
			a_win,
			"Group A",
			@data[:a_total],
			@data[:a_conv],
			"#{format(:a_conv_percent)} ( #{format(:a_low)}% - #{format(:a_high)}% )",
		]

		display_array << [
			b_win,
			"Group B",
			@data[:b_total],
			@data[:b_conv],
			"#{format(:b_conv_percent)} ( #{format(:b_low)}% - #{format(:b_high)}% )",
		]



		puts Hirb::Helpers::AutoTable.render(display_array,
			:headers =>
				%w(WINNER GROUP EVENTS SUCCESSES CONVERSION
					))


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

splital.pretty_print
