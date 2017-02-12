require 'json'
require 'ABAnalyzer'
require './data_print'

class DataScience
  attr_reader :confidence_level
  attr_reader :a_count
  attr_reader :a_conv_count
  attr_reader :avg_rate_a
  attr_reader :rate_a_low
  attr_reader :rate_a_high
  attr_reader :b_count
  attr_reader :b_conv_count
  attr_reader :avg_rate_b
  attr_reader :rate_b_low
  attr_reader :rate_b_high

  def initializer(_args = {})
    @visits = []
  end

  def parse_json_file(file_path)
    json_data = open_and_read_file(file_path)
    @visits = JSON.parse(json_data)
  end

  def successfully_loaded?
    return false if @visits.nil? || @visits.empty?
    true
  end

  def find_counts_per_cohort
    @a_count, @a_conv_count = find_counts_for_cohort('A')
    @b_count, @b_conv_count = find_counts_for_cohort('B')
  end

  def able_to_find_cohort_counts?
    return true if @a_count != 0 && @b_count != 0
    false
  end

  def calculate_average_conversion_rate
    @avg_rate_a = 0.0
    @avg_rate_b = 0.0

    @avg_rate_a = @a_conv_count.to_f / @a_count.to_f
    @avg_rate_b = @b_conv_count.to_f / @b_count.to_f
  end

  def able_to_calculate_avg_conv_rate?
    return false if @avg_rate_a == 0 || @avg_rate_b == 0
    true
  end

  def calculate_95_perc_conversion_rate_range
    @rate_a_low, @rate_a_high = calc_95_conv_rate_for(@a_count, @a_conv_count)
    @rate_b_low, @rate_b_high = calc_95_conv_rate_for(@b_count, @b_conv_count)
  end

  def able_to_calculate_95_conv_rate_ranges?
    if @rate_a_low == 0 || @rate_a_high == 0 ||
       @rate_b_low == 0 || @rate_b_high == 0
      return false
    end
    true
  end

  def calculate_confidence_level
    values = {}
    values['a'] = { 'conved' => @a_conv_count,
                    'unconved' => @a_count - @a_conv_count }
    values['b'] = { 'conved' => @b_conv_count,
                    'unconved' => @b_count - @b_conv_count }

    analyzer = ABAnalyzer::ABTest.new values

    @confidence_level = 0
    @confidence_level = analyzer.chisquare_p
  end

  def able_to_produce_confidence_level?
    return true if @confidence_level != 0
    false
  end

  private

  def open_and_read_file(file_path)
    file = File.open(file_path, "r")
    data = file.read
    file.close
    data
  end

  def find_counts_for_cohort(name)
    count = 0
    conv_count = 0
    @visits.each do |visit|
      if visit['cohort'] == name
        count += 1
        conv_count += visit['result']
      end
    end
    return count, conv_count
  end

  def calc_95_conv_rate_for(count, conv_count)
    result = ABAnalyzer.confidence_interval(conv_count, count, 0.95)
    low = result[0]
    high = result[1]
    return low, high
  end
end

file_path = './data_export_2014_06_20_15_59_02.json'
data_science = DataScience.new

data_science.parse_json_file(file_path)
data_science.find_counts_per_cohort

data_science.calculate_average_conversion_rate
data_science.calculate_95_perc_conversion_rate_range
data_science.calculate_confidence_level

DataPrint.print_avg_rates(data_science.avg_rate_a,
                          data_science.a_count,
                          data_science.a_conv_count,
                          data_science.avg_rate_b,
                          data_science.b_count,
                          data_science.b_conv_count)
DataPrint.print_rates_ranges(data_science.rate_a_low,
                             data_science.rate_a_high,
                             data_science.rate_b_low,
                             data_science.rate_b_high)
DataPrint.print_confidence_level(data_science.confidence_level)
