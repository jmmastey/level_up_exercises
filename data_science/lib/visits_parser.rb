require_relative 'visit'

class VisitsParser
	def self.parse(data)
		data.map do |datum|
			Visit.new(
				cohort: datum[:cohort],
				result: datum[:result],
				date: datum[:date]
			)
		end
	end
end