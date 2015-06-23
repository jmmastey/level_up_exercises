require 'abanalyzer'
require_relative 'error/format_error'

class DataAnalyzer
  attr_reader :dataset

  CONVERSION_CONFIDENCE = 0.95

  ERROR = {
    type: "Data must be a hash of hash values",
    positive: "Result hash for each cohort must contain key :conversions",
    negative: "Result hash for each cohort must contain key :non_conversions",
    result_type: "Result hash values for each cohort must be integer",
    range: "Precision value must be between 0 and 1",
  }

  def initialize(dataset)
    validate(dataset)
    @dataset = dataset
  end

  def conversion_rate(id)
    return { rate: 0, deviation: 0 } unless @dataset.key?(id)
    low, high = conversion_confidence(id)
    deviation = (high - low) / 2
    { rate: (high - deviation).round(2), deviation: deviation.round(2) }
  end

  def conclusive?(precision = 0.95)
    raise RangeError, ERROR[:range] unless (0.0..1.0).include?(precision)
    chisquare_p_threshhold = 1 - precision
    chisquare_p = ABAnalyzer::ABTest.new(@dataset).chisquare_p
    chisquare_p <= chisquare_p_threshhold
  end

  private

  def conversion_confidence(id, confidence = CONVERSION_CONFIDENCE)
    converted = @dataset[id][:conversions]
    size = converted + @dataset[id][:non_conversions]
    ABAnalyzer.confidence_interval(converted, size, confidence)
  end

  def valid_result_values?(result)
    pos = result[:conversions]
    neg = result[:non_conversions]
    pos.is_a?(Integer) && neg.is_a?(Integer)
  end

  def validate(data)
    raise FormatError, ERROR[:type] unless data.is_a?(Hash)
    data.each do |_cohort, result|
      raise FormatError, ERROR[:type] unless result.is_a?(Hash)
      validate_result(result)
    end
  end

  def validate_result(result)
    raise FormatError, ERROR[:positive] unless result.key?(:conversions)
    raise FormatError, ERROR[:negative] unless result.key?(:non_conversions)
    raise FormatError, ERROR[:result_type] unless valid_result_values?(result)
  end
end
