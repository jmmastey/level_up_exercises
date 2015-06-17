require 'abanalyzer'

class DataAnalyzer
  attr_reader :dataset

  GROUP = :cohort
  CONVERSION_CONFIDENCE = 0.95
  ERROR = {
    keys: "Data entries must contain keys :cohort and :result",
    values: "Values for data entries :result must be 0 or 1",
    range: "Precision value must be between 0 and 1",
  }

  def initialize(dataset)
    validate(dataset)
    @dataset = dataset
  end

  def conclusive?(precision = 0.95)
    raise ERROR[:range] unless (0.0..1.0).include?(precision)
    chisquare_p_threshhold = 1 - precision
    values = values_hash(@dataset)
    chisquare_p = ABAnalyzer::ABTest.new(values).chisquare_p
    chisquare_p <= chisquare_p_threshhold
  end

  def conversion_rate(id)
    return { rate: 0, deviation: 0 } if sample_size(id) == 0
    low, high = conversion_range(group(id), CONVERSION_CONFIDENCE)
    deviation = (high - low) / 2
    { rate: (high - deviation).round(2), deviation: deviation.round(2) }
  end

  def num_conversions(id)
    group(id).count { |entry| entry[:result] == 1 }
  end

  def sample_size(id)
    group(id).size
  end

  private

  def base_hash
    @dataset.each_with_object({}) do |data, memo|
      memo[data[GROUP]] ||= base_values
    end
  end

  def base_values
    { conversions: 0, non_conversions: 0 }
  end

  def conversion_range(group, confidence)
    converted = group.count { |data| data[:result] == 1 }
    ABAnalyzer.confidence_interval(converted, group.size, confidence)
  end

  def group(group_id)
    @dataset.select { |data| data[GROUP] == group_id }
  end

  def values_hash(dataset)
    dataset.each_with_object(base_hash) do |data, memo|
      memo[data[GROUP]][:conversions] += 1 if data[:result] == 1
      memo[data[GROUP]][:non_conversions] += 1 if data[:result] == 0
    end
  end

  def validate(dataset)
    dataset.each do |data|
      raise ERROR[:keys] unless data.key?(GROUP) && data.key?(:result)
      raise ERROR[:values] unless data[:result] == 0 || data[:result] == 1
    end
  end
end
