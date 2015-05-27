require 'abanalyzer'
require_relative './data_loader.rb'

class ABSplitTester
  def initialize(data)
    @cohorts = []
    @visitors = {}
    @conversions = {}
    @raw_data = data

    @raw_data.each do |row|
      @cohorts << row["cohort"]
      @conversions[row["cohort"]] ||= 0
      @visitors[row["cohort"]] ||= 0

      @conversions[row["cohort"]] += row["result"]
      @visitors[row["cohort"]] += 1
    end

    @cohorts.uniq!
  end

  def cohorts_count
    @cohorts.size
  end

 def conversion_count(cohort)
   raise "Invalid Cohort" unless @cohorts.include? cohort

   @conversions[cohort]
 end

 def conversion_rate(cohort)
   raise "Invalid Cohort" unless @cohorts.include? cohort

   ABAnalyzer.confidence_interval(@conversions[cohort], @visitors[cohort], 0.95)
 end

 def confidence_score
   values = {}
   @conversions.each do |cohort, value|
     values[cohort] = { converted: value, not_converted: (@visitors[cohort] - value) }
   end

   tester = ABAnalyzer::ABTest.new values
  #  puts tester.chisquare_p
   1-tester.chisquare_p
 end
  # private

  # def check_cohort_validity()
  #
  # end
  # def process(data)
  #   split_into_cohorts(data)
  # end
  #
  # def split_into_cohorts
  # end

end
