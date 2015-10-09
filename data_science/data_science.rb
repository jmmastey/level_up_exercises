require 'json'
require 'ABAnalyzer'

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
		# return if !File.exists?(file_path)

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
		@cohortACount = 0
		@cohortBCount = 0
		@cohortAConvCount = 0
		@cohortBConvCount = 0

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

		@avgRateA = @cohortAConvCount.to_f / @cohortACount.to_f
		@avgRateB = @cohortBConvCount.to_f / @cohortBCount.to_f
	end

	def able_to_calculate_avg_conv_rate?
		if @avgRateA == 0 || @avgRateB == 0
			return false
		end
		true
	end

	def calculate_95_perc_conversion_rate_range(cohort)
		case cohort
		  when "A"
			@rateALowRange = 0 
			@rateAHighRange = 0

			result = ABAnalyzer.confidence_interval(@cohortAConvCount, @cohortACount, 0.95)
			@rateALowRange = result[0]
			@rateAHighRange = result[1]
		  when "B"
			@rateBLowRange = 0 
			@rateBHighRange = 0

			result = ABAnalyzer.confidence_interval(@cohortBConvCount, @cohortBCount, 0.95)
			@rateBLowRange = result[0]
			@rateBHighRange = result[1]			
		end
			
	end

	def able_to_calculate_95_conv_rate_ranges?
		if @rateALowRange == 0 || @rateAHighRange == 0 || @rateBLowRange == 0 || @rateBHighRange == 0
			return false
		end
		true
	end

	def calculate_confidence_level 
		# dropped here cause need to integrate manually ABAnalyzer as I can't build the gem :(
			values = Hash.new
			values['a'] = { 'conved' => @cohortAConvCount, 'unconved' => @cohortACount-@cohortAConvCount}
			values['b'] = { 'conved' => @cohortBConvCount, 'unconved' => @cohortBCount-@cohortBConvCount}

			analyzer = ABAnalyzer::ABTest.new values

			@confidenceLevel = 0
			@confidenceLevel = analyzer.chisquare_p
	end

	def able_to_produce_confidence_level?
		if @confidenceLevel != 0 
			return true
		end
		false
	end

	def show_avg_rates
		# presentable values.
		avgRateAPres = @avgRateA *100
		convCountAPres = @cohortAConvCount * 100
		countAPres = @cohortACount * 100

		avgRateBPres = @avgRateB * 100
		convCountBPres = @cohortBConvCount * 100
		countBPres = @cohortBCount * 100
		
		puts "Avg A Rate: "+avgRateAPres.round(2).to_s+"% ("+convCountAPres.to_s+"/"+countAPres.to_s+")"
		puts "Avg B Rate: "+avgRateBPres.round(2).to_s+"% ("+convCountBPres.to_s+"/"+ countBPres.to_s+")"
	end

	def show_rates_ranges
		#presentable values
		aLowPres = @rateALowRange * 100
		aHighPres = @rateAHighRange * 100

		bLowPres = @rateBLowRange * 100
		bHighPres = @rateBHighRange * 100

		puts "A Rates: ["+aLowPres.round(2).to_s+"% - "+aHighPres.round(2).to_s+"%]"
		puts "B Rates: ["+bLowPres.round(2).to_s+"% - "+bHighPres.round(2).to_s+"%]"
	end

	def show_confidence_level
		#presentable values
		confPres = @confidenceLevel * 100

		puts "Confidence Level: "+confPres.round(2).to_s+"%"
	end

end

filePath = './data_export_2014_06_20_15_59_02.json'
dataScience = DataScience.new

dataScience.parse_json_file(filePath)
dataScience.find_counts_per_cohort

dataScience.calculate_average_conversion_rate
dataScience.calculate_95_perc_conversion_rate_range("A")
dataScience.calculate_95_perc_conversion_rate_range("B")
dataScience.calculate_confidence_level

dataScience.show_avg_rates
dataScience.show_rates_ranges
dataScience.show_confidence_level


