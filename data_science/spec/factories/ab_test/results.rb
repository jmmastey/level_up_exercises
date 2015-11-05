require 'abanalyzer'
require 'data_science/ab_test/result'
require 'factories/cohorts'

FactoryGirl.define do
  factory :ab_test_result, class: DataScience::ABTest::Result do
    a_cohort FactoryGirl.build(:a_cohort)
    b_cohort FactoryGirl.build(:b_cohort)
    a_conversion_rate [0.12345, 0.23456]
    b_conversion_rate [0.05678, 0.07891]
    confidence 0.95678
    initialize_with { new(a_cohort, b_cohort, a_conversion_rate, b_conversion_rate, confidence) }
  end
end
