require 'json'

class DataScience
	@visits
	@cohortACount
	@cohortBCount
	@cohortAConvCount
	@cohortBConvCount

	@avgRateA
	@rateALowRange 
	@rateAHighRange

	@avgRateB
	@rateBLowRange 
	@rateBHighRange

	def initializer(args = {})
		@visits = Array.new
	end

	def open_and_read_file(file_path)
		file = File.open(file_path, "r")
		data = file.read
		file.close
		return data
	end

	def parse_json_file(file_path)
		json_data = open_and_read_file(file_path)

		@visits = JSON.parse(json_data)		
	end

	def successfully_loaded?
		if @visits == nil || @visits.empty?
			return false
		 end
		 true
	end

	def find_counts_per_cohort
		@cohortACount = 0.0
		@cohortBCount = 0.0
		@cohortAConvCount = 0.0
		@cohortBConvCount = 0.0

		@visits.each do |visit| 
			cohortForVisit = visit['cohort']
			conversionForVisit = visit['result']

			case cohortForVisit
			when 'A'
				@cohortACount += 1
				@cohortAConvCount += conversionForVisit
			when 'B'
				@cohortBCount += 1
				@cohortBConvCount += conversionForVisit
			else 
				next
			end
		end

	end

	def able_to_find_cohort_counts?
		if @cohortACount != 0 && @cohortBCount != 0 
			return true
		end
		false
	end

	def calculate_average_conversion_rate
		@avgRateA = 0.0
		@avgRateB = 0.0

		@avgRateA = @cohortAConvCount / @cohortACount * 100
		@avgRateB = @cohortBConvCount / @cohortBCount * 100
	end

	def able_to_calculate_avg_conv_rate?
		if @avgRateA == 0 && @avgRateB == 0
			return false
		end
		true
	end

	def calculate_95_perc_conversion_rate_range(avg_conv_rate, trial_count, cohort)
		@rateBLowRange = 0 
		@rateBHighRange = 0
		@rateALowRange = 0 
		@rateAHighRange = 0
		se = sqrt(avg_conv_rate*(1-avg_conv_rate)/trial_count)

		if cohort == "A"
			@rateALowRange = avg_conv_rate % 1.96 * se
			@rateAHighRange = avg_conv_rate % -1.96 * se
		elsif cohort == "B"
			@rateBLowRange = avg_conv_rate % 1.96 * se
			@rateBHighRange = avg_conv_rate % -1.96 * se
		end
			
	end

	def able_to_calculate_95_conv_rate_ranges?
		if @rateALowRange == 0 && @rateAHighRange == 0 && @rateBLowRange == 0 && @rateBHighRange == 0
			return false
		end
		true
	end

	def calculate_confidence_level 
		# dropped here cause need to integrate manually ABAnalyzer as I can't build the gem :(
	end


	def show_avg_rates
		print "Avg A Rate: "+@avgRateA.round(2).to_s+"% ("+@cohortAConvCount.to_s+"/"+@cohortACount.to_s+")\n"
		print "Avg B Rate: "+@avgRateB.round(2).to_s+"% ("+@cohortBConvCount.to_s+"/"+ @cohortBCount.to_s+")\n"
	end

	def show_rates_ranges
		print "A Rates: ["+@rateALowRange+" - "+@rateAHighRange+"]\n"
		print "B Rates: ["+@rateBLowRange+" - "+@rateBHighRange+"]\n"
	end

end

