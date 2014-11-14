# A/B Splite Test
class ABTestData
  attr_reader :total_samples, :conversions, :non_conversions
  Z_SCORE = 1.96
  KEY_MISSING = 'The json does not contains require keys'
  NO_NEGATIVE = 'Both total_samples and conversions can not be negative'
  def initialize(data = {})
    fail ArgumentError if data.empty?
    fail KEY_MISSING unless data.key?(:total_samples) && data.key?(:conversions)
    fail NO_NEGATIVE unless data[:total_samples] > 0 && data[:conversions] >= 0
    @total_samples = data[:total_samples].to_f
    @conversions = data[:conversions].to_f
    @non_conversions = @total_samples - @conversions
  end

  def conversion_rate
    @conversions / @total_samples
  end

  def standard_error
    # square root of p(1-p)/total sample
    p = conversion_rate
    numerator = p * (1 - p)
    Math.sqrt((numerator / @total_samples))
  end

  def distribution_range
    rate = conversion_rate
    sample_mean = Z_SCORE * standard_error
    [(rate - sample_mean).round(4), (rate + sample_mean).round(4)]
  end
end
