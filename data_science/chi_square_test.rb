require_relative 'ab_test_data'

module ChiSquareTest
  def self.calculate(data_a, data_b)
    numerator(data_a, data_b) / denominator(data_a, data_b)
  end

  private

  def self.numerator(data_a, data_b)
    (((data_a.conversions * data_b.non_conversions) -
    (data_a.non_conversions * data_b.conversions))**2) *
    (data_a.total_samples + data_b.total_samples)
  end

  def self.denominator(data_a, data_b)
    (data_a.total_samples) * (data_b.total_samples) *
    (data_a.non_conversions + data_b.non_conversions) *
    (data_a.conversions + data_b.conversions)
  end
end
