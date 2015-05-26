require 'abanalyzer'
require 'json'
require './cohort'
require 'pry'

class SplitTest
  attr_reader :cohorts
  attr_reader :confidence
  attr_writer :file

  EXPECTED_KEYS = %w(date cohort result)

  class NoDataSourceError < StandardError
    def message
      "No data source (file) was specified"
    end
  end

  class FileNotFoundError < StandardError
    def message
      "File not found"
    end
  end

  class InvalidDataFormatError < StandardError
    def initialize(missing_key = nil)
      @missing_key = missing_key
    end

    def message
      error = "Invalid data format"
      error += ": " + @missing_key + " key is missing" unless @missing_key.nil?
      error
    end
  end

  class InsufficientDataError < StandardError
    def initialize(message = '')
      @message = message
    end

    def message
      @message
    end
  end

  def initialize(file = nil)
    @cohorts = {}
    @file = file unless file.nil?
  end

  def generate_report(file = nil)
    define_data_source(file)
    read_data
    parse_data
    tally_results
  end

  private

  def define_data_source(file = nil)
    @file = file unless file.nil?
    raise NoDataSourceError if @file.nil?
  end

  def read_data
    @file_data = File.read(@file)
  rescue Errno::ENOENT
    raise FileNotFoundError
  end

  def parse_data
    @data = JSON.parse(@file_data)
  rescue
    raise InvalidDataFormatError
  end

  def tally_results
    @data.each do |sample|
      check_headers(sample)
      cohort_name = sample['cohort'].downcase.to_sym
      @cohorts[cohort_name] = Cohort.new if @cohorts[cohort_name].nil?
      @cohorts[cohort_name].add_sample_result(sample['result'])
    end
    calculate_confidence
  end

  def check_headers(sample)
    EXPECTED_KEYS.each do |expected_key|
      unless sample.key?(expected_key)
        error = InvalidDataFormatError.new(expected_key)
        raise error
      end
    end
  end

  def calculate_confidence
    values = formatted_ab_values
    tester = ABAnalyzer::ABTest.new(values)
    @confidence = tester.chisquare_p
  rescue ABAnalyzer::InsufficientDataError => e
    error = InsufficientDataError.new(e.message)
    raise error
  end

  def formatted_ab_values
    values = {}
    @cohorts.each do |name, data|
      values[name] = { yes: data.yes, no: data.no }
    end
    values
  end
end
