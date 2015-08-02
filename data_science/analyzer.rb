require 'json'
require 'pp'

class Analyzer
	def initialize(filename)
		@filename = filename
	end

	def parse_data
		data = JSON.parse(File.read(@filename))
		group_data = Hash.new{[]}
		data.each do |r|
			cohort_group = r["cohort"]
			cohort_result = r["result"]
			group_data[cohort_group] <<= cohort_result
		end
		group_data
	end
end
