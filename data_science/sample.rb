require 'abanalyzer'

class Sample
  attr_accessor :sample, :result_key, :valid_result
  attr_reader :size, :conversions
  RESULT_KEY_DEFAULT = "result"
  VALID_RESULT_DEFAULT = 1

  def initialize(results, field_info = {})
    self.sample = results
    self.result_key = field_info.fetch(:result_key, RESULT_KEY_DEFAULT)
    self.valid_result = field_info.fetch(:valid_result, VALID_RESULT_DEFAULT)
  end

  def size
    @size ||= sample.length
  end

  def conversions
    @conversions ||= sample.count { |user| user[result_key] == valid_result }
  end

  def non_conversions
    @non_conversions ||= size - conversions
  end

  def confidence_interval(confidence)
    ABAnalyzer.confidence_interval(conversions, size, confidence)
  end
end
