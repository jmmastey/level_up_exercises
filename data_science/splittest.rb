require 'abanalyzer'
require 'json'
require './cohort'
require './splittest_exceptions'

class SplitTest
  attr_reader :cohorts

  EXPECTED_KEYS = %w(date cohort result)

  def initialize
    @cohorts = {}
  end

  def generate_report(file)
    raise Exceptions::NoDataSourceError if file.nil?
    file_data = read_data(file)
    data = parse_data(file_data)
    tally_results(data)
    self
  end

  def confidence
    raise Exceptions::NoDataSourceError if @cohorts.length < 1
    tester = ABAnalyzer::ABTest.new(formatted_ab_values)
    tester.chisquare_p
  rescue ABAnalyzer::InsufficientDataError => e
    error = Exceptions::InsufficientDataError.new(e.message)
    raise error
  end

  private

  def read_data(file)
    File.read(file)
  rescue Errno::ENOENT
    raise Exceptions::FileNotFoundError
  end

  def parse_data(file_data)
    JSON.parse(file_data)
  rescue
    raise Exceptions::InvalidDataFormatError
  end

  def tally_results(data)
    data.each do |sample|
      check_headers(sample)
      cohort_name = sample['cohort'].downcase.to_sym
      @cohorts[cohort_name] ||= Cohort.new
      @cohorts[cohort_name].add_sample_result(sample['result'])
    end
  end

  def check_headers(sample)
    EXPECTED_KEYS.each do |expected_key|
      unless sample.key?(expected_key)
        error = Exceptions::InvalidDataFormatError.new(expected_key)
        raise error
      end
    end
  end

  def formatted_ab_values
    values = {}
    @cohorts.each do |name, data|
      values[name] = { yes: data.yes, no: data.no }
    end
    values
  end
end
