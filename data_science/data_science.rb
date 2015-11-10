require 'json'
require 'ABAnalyzer'
require './data_print'
require './cohort_attributes'

class DataScience
  attr_reader :confidence_level
  attr_reader :cohort_a, :cohort_b

  def initialize(file_path)
    @visits = []
    @cohort_a = CohortAttributes.new
    @cohort_b = CohortAttributes.new
    json_data = open_and_read_file(file_path)
    @visits = JSON.parse(json_data)
  end

  def successfully_loaded?
    !@visits.nil? || !@visits.empty?
  end

  def find_counts_per_cohort
    @cohort_a.count, @cohort_a.conversions = find_counts_for_cohort('A')
    @cohort_b.count, @cohort_b.conversions = find_counts_for_cohort('B')
  end

  def calculate_average_conversion_rate
    @cohort_a.avg_rate = @cohort_a.conversions.to_f / @cohort_a.count.to_f
    @cohort_b.avg_rate = @cohort_b.conversions.to_f / @cohort_b.count.to_f
  end

  def able_to_calculate_avg_conv_rate?
    @cohort_a.avg_rate != 0 && @cohort_b.avg_rate != 0
  end

  def calculate_95_perc_conversion_rate_range
    @cohort_a.rate_low, @cohort_a.rate_high =
      calc_95_conv_rate_for(@cohort_a.count, @cohort_a.conversions)
    @cohort_b.rate_low, @cohort_b.rate_high =
      calc_95_conv_rate_for(@cohort_b.count, @cohort_b.conversions)
  end

  def able_to_calculate_95_conv_rate_ranges?
    if @cohort_a.rate_low == 0 || @cohort_a.rate_high == 0 ||
       @cohort_b.rate_low == 0 || @cohort_b.rate_high == 0
      return false
    end
    true
  end

  def confidence_interval(cohort)
    { converted: cohort.conversions, unconverted: cohort.count - cohort.conversions }
  end

  def calculate_confidence_level
    values = {}
    values['a'] = confidence_interval(cohort_a)
    values['b'] = confidence_interval(cohort_b)

    analyzer = ABAnalyzer::ABTest.new values

    @confidence_level = 0
    @confidence_level = analyzer.chisquare_p
  end

  def able_to_produce_confidence_level?
    @confidence_level != 0
  end

  private

  def open_and_read_file(file_path)
    file = File.open(file_path, "r")
    data = file.read
    file.close
    data
  end

  def find_counts_for_cohort(name)
    cohort_visits = @visits.select { |v| v['cohort'] == name }
    conversions = cohort_visits.inject(0) { |sum, v| sum += v['result'] }
    return cohort_visits.size, conversions
  end

  def calc_95_conv_rate_for(count, conv_count)
    result = ABAnalyzer.confidence_interval(conv_count, count, 0.95)
    return result[0], result[1]
  end
end

file_path = './data_export_2014_06_20_15_59_02.json'
data_science = DataScience.new(file_path)

data_science.find_counts_per_cohort

data_science.calculate_average_conversion_rate
data_science.calculate_95_perc_conversion_rate_range
data_science.calculate_confidence_level

DataPrint.print_avg_rates(data_science.cohort_a.avg_rate,
                          data_science.cohort_a.count,
                          data_science.cohort_a.conversions,
                          data_science.cohort_b.avg_rate,
                          data_science.cohort_b.count,
                          data_science.cohort_b.conversions)
DataPrint.print_rates_ranges(data_science.cohort_a.rate_low,
                             data_science.cohort_a.rate_high,
                             data_science.cohort_b.rate_low,
                             data_science.cohort_b.rate_high)
DataPrint.print_confidence_level(data_science.confidence_level)
