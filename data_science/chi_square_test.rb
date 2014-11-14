require_relative 'ab_test_data'

# This module provides the method to calculate 2x2 Chi-Square Test
module ChiSquareTest
  def self.calculate(data_a = nil, data_b = nil)
    fail 'Both inputs cannot be nil' if data_a.nil? || data_b.nil?
    unless data_a.instance_of?(ABTestData) && data_b.instance_of?(ABTestData)
      fail 'Both inputs must be instance of ABTestData'
    end
    numerator(data_a, data_b) / denominator(data_a, data_b)
  end

  private

  def self.numerator(data_a, data_b)
    numerator = (((data_a.conversions * data_b.non_conversions) -
                (data_a.non_conversions * data_b.conversions))**2) *
                (data_a.total_samples + data_b.total_samples)
    numerator
  end

  def self.denominator(data_a, data_b)
    denominator = (data_a.total_samples) * (data_b.total_samples) *
                  (data_a.non_conversions + data_b.non_conversions) *
                  (data_a.conversions + data_b.conversions)
    denominator
  end
end
