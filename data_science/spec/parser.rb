require "json"
require_relative 'visitor'
require_relative 'cohort'

module Parser

	def self.parse(file)
		visitors = []
		jsonStuff = JSON.parse(File.read(file), symbolize_names: true)
		jsonStuff.each { |obj| visitors << Visitor.new(obj) }
		seperate_into_cohorts(visitors)
	end

	def self.seperate_into_cohorts(visitors)
		grouped = visitors.group_by { |visitor| visitor.cohort }
		[build_cohort(grouped['A']), build_cohort(grouped['B']) ]
	end

	private

	def self.build_cohort(visitors)
		cohort = Cohort.new
		visitors.each { |visitor| cohort.add(visitor) }
		cohort
		#REFACTOR: visitors.inject(Cohort.new) { |cohort.new, visitor| cohort.add(visitor) }
	end

end
