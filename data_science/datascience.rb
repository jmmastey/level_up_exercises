require 'abanalyzer'
require 'pry'
require_relative 'parser'
require_relative 'cohort'

class DataScience
  attr_reader :json_file

  def initialize(json_file = 'source_data.json')
    @json_file = json_file
  end

  def data
    @data ||= Parser.parse(json_file)
  end

  def chi_sq
    difference = tester.different?
    chi = tester.chisquare_p.round(3)
    [difference, chi]
  end

  def conversion_rate
    cohort_names.each_with_object({}) do |cohort, rates|
      conversions = counts["#{cohort}_1"]
      total = counts["#{cohort}_total"]
      rates["#{cohort}"] = (Float(conversions) / Float(total)).round(3)
    end
  end

  def conversion_rate_error
    cohort_names.each_with_object({}) do |cohort, errors|
      rate = conversion_rate["#{cohort}"]
      error = (Math.sqrt(rate * (1 - rate) / (sample_size)) * 1.96)
      errors["#{cohort}"] = error.round(3)
    end
  end

  def counts
    @counts ||= Parser.counts(data)
  end

  private

  def cohort_names
    @cohort_names ||= Parser.cohort_names(data)
  end

  def sample_size
    cohort_names.inject(0) do |sum, name|
      sum + counts["#{name}_total"]
    end
  end

  def values
    {
      agroup: { :"1" => counts["A_1"], :"0" => counts["A_0"] },
      bgroup: { :"1" => counts["B_1"], :"0" => counts["B_0"] },
    }
  end

  def tester
    @tester ||= ABAnalyzer::ABTest.new(values)
  end
end

data = DataScience.new
puts data.counts
puts data.chi_sq
puts data.conversion_rate
puts data.conversion_rate_error
