class Cohort
	attr_accessor :members

	def initialize(*members)
		@members = members
	end

	def sample_size()
		@members.length
	end

	def conversions
		@members.select {|member| member.result == 1}.length
	end
end