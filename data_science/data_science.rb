require 'json'
require 'abanalyzer'
require_relative 'data_loader'

class Optimizer
  attr_accessor :data

  def initialize(initial_data)
    @data = DataLoader.load_data(initial_data)
  end

  def simple_counts
    [:A, :B].each_with_object({}) do |cohort, result|
      result[cohort] = { sample_size: @data[cohort].values.inject(:+),
                         conversions: @data[cohort][:successes] }
    end
  end

  def conversion_rates
    counts = simple_counts
    [:A, :B].each_with_object({}) do |cohort, result|
      result[cohort] = ABAnalyzer.confidence_interval(
        counts[cohort][:conversions], counts[cohort][:sample_size], 0.95)
    end
  end

  def result_confidence
    tester = ABAnalyzer::ABTest.new(@data)
    tester.chisquare_p
  end
end

optimizer = Optimizer.new("data_export_2014_06_20_15_59_02.json")
puts optimizer.result_confidence
