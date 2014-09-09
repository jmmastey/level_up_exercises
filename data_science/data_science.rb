require 'json'
require 'set'
require_relative 'stat_calculator'
require_relative 'cohort'

class Split_Test
  attr_accessor :cohorts

	def initialize(filename)
		@cohorts = []
		parse(filename)
	end

	def calculate_stats
	  @cohorts.each do |cohort|
			cohort.conversion = Stat_Calculator.conversion(cohort.stats[:positive], cohort.stats[:total])
			cohort.standard_error = Stat_Calculator.standard_error(cohort.conversion, cohort.stats[:total])
		end
	end

	def output_stats
		@cohorts.each do |cohort|
      raise RuntimeError, "Must invoke calculate_stats before outputting them" if cohort.conversion.nil? || cohort.standard_error.nil?
    end
    
		puts Stat_Calculator.chi_square(*@cohorts.inject([]) { |collection, cohort| collection << cohort.stats[:positive] << cohort.stats[:negative] })
		
		@cohorts.each { |cohort| puts cohort.to_s }
	end

	private
	def parse(filename)
		hash = JSON.parse(File.read(filename))
		hash.each do |datapoint|
      cohort = find_or_create_cohort(datapoint["cohort"])
			if datapoint["result"] == 0
				cohort.stats[:negative] += 1
			else
				cohort.stats[:positive] += 1
			end
			cohort.stats[:total] += 1
		end
	end

  def find_or_create_cohort(name)
    new_cohort = Cohort.new(name)
    @cohorts.each do |cohort|
      return cohort if cohort.eql? new_cohort
    end
    @cohorts << new_cohort
    new_cohort
  end

end
