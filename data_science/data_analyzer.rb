require_relative 'json_reader'
require 'abanalyzer'

class DataAnalyzer
  attr_accessor :data

  def initialize(file_path)
    @data_array = JSONReader.read_json_file(file_path)
  end

  def sample_size(cohort)
    @data_array.count { |data| data["cohort"] == cohort }
  end

  def num_conversions(cohort)
    @data_array.count { |data| data["cohort"] == cohort && data["result"] == 1 }
  end

  def num_fails(cohort)
    @data_array.count { |data| data["cohort"] == cohort && data["result"] == 0 }
  end

  def conversion_rate(cohort)
    rate = num_conversions(cohort).to_f / sample_size(cohort)
    round_value(rate)
  end

  def standard_error(cohort)
    rate = conversion_rate(cohort)
    se = Math.sqrt(rate * (1 - rate) / sample_size(cohort))
    round_value(se)
  end

  def better_than_random?
    tester = ABAnalyzer::ABTest.new(values_to_hash)
    tester.different?
  end

  def values_to_hash
    values = {}
    values[:a] = { conversion: num_conversions("A"), fails: num_fails("A") }
    values[:b] = { conversion: num_conversions("B"), fails: num_fails("B") }
    values
  end

  def round_value(value)
    (value * 1000).round / 1000.0
  end

  def conversion_rate_range(cohort)
    range = []
    left_value = conversion_rate(cohort) - 1.96 * standard_error(cohort)
    right_value = conversion_rate(cohort) + 1.96 * standard_error(cohort)
    left_value = round_value(left_value)
    right_value = round_value(right_value)
    range << (left_value < 0 ? 0 : left_value)
    range << (right_value > 1 ? 1 : right_value)
  end
end
