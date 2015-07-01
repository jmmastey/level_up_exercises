require_relative 'data_loader.rb'
require_relative 'cohort.rb'
require 'abanalyzer'
# Error classes for missing labels
class InvalidCohortLblError < RuntimeError
  def message
    'This cohort does not have a label of A or B so it is invalid'
  end
end
# Error classes for missing dates
class InvalidCohortDateError < RuntimeError
  def message
    'This cohort does not have a date so it is invalid'
  end
end
# This class is used for a Split test
class SplitTestAB
  attr_accessor :cohorta, :cohortb, :nonconversions
  def initialize(data)
    @visitors = 0
    @cohorta    =  Cohort.new
    @cohortb  =   Cohort.new
    @values = {}
    calculate(data)
  end

  def calculate(data)
    data.each do |row|
      raise InvalidCohortLblError unless %w(A B).include?(row['cohort'])
      raise InvalidCohortDateError  if row['date'].empty?
      @cohorta.calc_conversion_nonconversion(row['result']) if row['cohort'].upcase == 'A'
      @cohortb.calc_conversion_nonconversion(row['result']) if row['cohort'].upcase == 'B'
      @visitors += 1
    end
  end

  def create_converhash(conversion, nonconversion)
    analyzer_cohort_data = {}
    analyzer_cohort_data[:converted] = conversion
    analyzer_cohort_data[:nonconverted] = nonconversion
    analyzer_cohort_data
  end

  def confidence_score
    @values[:cohorta] = create_converhash(@cohorta.conversions, @cohorta.nonconversions)
    @values[:cohortb] = create_converhash(@cohortb.conversions, @cohortb.nonconversions)
    tester = ABAnalyzer::ABTest.new @values
    tester.chisquare_p
  end
end
