require_relative './error/format_error'
require_relative './error/value_error'

class DataParser
  attr_reader :data

  ERROR = {
    keys: "Data entries must contain keys :cohort and :result",
    values: "Values for data entries :result must be 0 or 1",
  }

  def initialize(dataset)
    validate(dataset)
    @data = dataset
  end

  def num_conversions(id)
    group(id).count { |entry| entry[:result] == 1 }
  end

  def sample_size(id)
    group(id).size
  end

  def summary
    @data.each_with_object(base_hash) do |data, memo|
      memo[data[:cohort]][:conversions] += 1 if data[:result] == 1
      memo[data[:cohort]][:non_conversions] += 1 if data[:result] == 0
    end
  end

  private

  def base_hash
    @data.each_with_object({}) do |data, memo|
      memo[data[:cohort]] ||= base_values
    end
  end

  def base_values
    { conversions: 0, non_conversions: 0 }
  end

  def group(group_id)
    @data.select { |data| data[:cohort] == group_id }
  end

  def valid_keys?(data)
    data.key?(:cohort) && data.key?(:result)
  end

  def valid_values?(data)
    data[:result] == 0 || data[:result] == 1
  end

  def validate(dataset)
    dataset.each do |data|
      raise FormatError, ERROR[:keys] unless valid_keys?(data)
      raise ValueError, ERROR[:values] unless valid_values?(data)
    end
  end
end
