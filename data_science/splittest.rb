require 'abanalyzer'
require 'json'

class SplitTest
  attr_reader :cohorts

  @@confidence_interval = 0.95
  @@expected_keys = %w(date cohort result)

  def initialize(file)
    get_data(file)
    check_data_format
    tally_results
    create_tester
    add_totals
    check_results
    analyze_results
  end

  private

  def get_data(file)
    @data = JSON.parse(File.read(file))
  rescue
    raise 'file not found'
  end

  def check_data_format
    @@expected_keys.each do |expected_key|
      raise 'invalid data format' unless @data.first.key?(expected_key)
    end
  end

  def tally_results
    @cohorts = {}
    @data.each do |sample|
      cohort = sample['cohort'].to_sym
      @cohorts[cohort] = { no: 0.0, yes: 0.0 } unless @cohorts.key?(cohort)

      @cohorts[cohort][:no] += 1 unless sample['result'] == 1
      @cohorts[cohort][:yes] += 1 unless sample['result'] == 0
    end
  end

  def create_tester
    @abtester = ABAnalyzer::ABTest.new @cohorts
  rescue ABAnalyzer::InsufficientDataError
    raise 'insufficient data'
  end

  def add_totals
    @cohorts.each do |cohort, cohort_data|
      @cohorts[cohort][:total] = cohort_data[:yes] + cohort_data[:no]
    end
  end

  def check_results
    @cohorts.each do |cohort, cohort_data|
      @cohorts[cohort][:total] = @cohorts[cohort][:yes] + @cohorts[cohort][:no]
      raise 'insufficient data' unless cohort_data[:total] >= 20
    end
  end

  def analyze_results
    @cohorts.each do |cohort, cohort_data|
      @cohorts[cohort][:error_bars] = ABAnalyzer.confidence_interval(cohort_data[:yes], cohort_data[:total], @@confidence_interval)
      @cohorts[cohort][:conversion_rate] = cohort_data[:yes] / cohort_data[:total]
      @cohorts[cohort][:confidence] = @@confidence_interval
    end
  end
end
