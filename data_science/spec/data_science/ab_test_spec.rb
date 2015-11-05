require 'data_science/ab_test'

describe DataScience::ABTest do
  let(:a_cohort) { build(:a_cohort) }
  let(:b_cohort) { build(:b_cohort) }

  let(:ab_analyzer) { class_double('ABAnalyzer').as_stubbed_const(transfer_nested_constants: true) }

  let(:ab_test) { DataScience::ABTest.new }

  it 'provides the a cohort in the results' do
    results = ab_test.parse_test_results(a_cohort, b_cohort)
    expect(results.a_cohort).to equal a_cohort
  end

  it 'provides the b cohort in the results' do
    results = ab_test.parse_test_results(a_cohort, b_cohort)
    expect(results.b_cohort).to equal b_cohort
  end

  it 'provides the a conversion rate in the results' do
    expect(ab_analyzer).to receive(:confidence_interval).with(a_cohort.yes, a_cohort.size, 0.95) { :a_conversion }
    expect(ab_analyzer).to receive(:confidence_interval).with(anything, anything, anything)

    results = ab_test.parse_test_results(a_cohort, b_cohort)
    expect(results.a_conversion_rate).to equal :a_conversion
  end

  it 'provides the b conversion rate in the results' do
    expect(ab_analyzer).to receive(:confidence_interval).with(anything, anything, anything)
    expect(ab_analyzer).to receive(:confidence_interval).with(b_cohort.yes, b_cohort.size, 0.95) { :b_conversion }

    results = ab_test.parse_test_results(a_cohort, b_cohort)
    expect(results.b_conversion_rate).to equal :b_conversion
  end

  it 'provides the confidence in the results' do
    tester = double
    expect(ABAnalyzer::ABTest).to receive(:new).with(a: a_cohort.to_h, b: b_cohort.to_h) { tester }
    expect(tester).to receive(:chisquare_p) { 0.2 }

    results = ab_test.parse_test_results(a_cohort, b_cohort)
    expect(results.confidence).to equal 0.8
  end
end
