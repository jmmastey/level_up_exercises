class Visit
	attr_reader :cohort, :date, :result

	def initialize(data)
		@cohort = data.fetch(:cohort)
		@result = data.fetch(:result)
		@date = data.fetch(:date)
	end
end