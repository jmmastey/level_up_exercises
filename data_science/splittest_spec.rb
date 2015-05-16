require './splittest'

describe SplitTest do
  data_source = 'data/test_data.json'

  it 'should return a "file not found" error if a data set could not be found' do
    expect { SplitTest.new('data/file_does_not_exist.json') }.to raise_error('file not found')
  end

  it 'should return an "invalid data format" error if the data set is not in the expected format' do
    expect { SplitTest.new('data/test_data_wrong_format.json') }.to raise_error('invalid data format')
  end

  it 'should return an "insufficient data" error if data set is not large enough (minimum 20 samples per cohort)' do
    expect { SplitTest.new('data/test_data_small_sample.json') }.to raise_error('insufficient data')
  end

  it 'should return a positive number to represent the total number of samples per cohort' do
    split_test = SplitTest.new(data_source)
    split_test.cohorts.each do |_cohort, cohort_data|
      expect(cohort_data[:total]).to be >= 0
    end
  end

  it 'should return a positive number (or zero) to represent the total number of conversions per cohort' do
    split_test = SplitTest.new(data_source)
    split_test.cohorts.each do |_cohort, cohort_data|
      expect(cohort_data[:yes]).to be >= 0
    end
  end

  it 'should return a number between 0 and 1 to represent the conversion rate' do
    split_test = SplitTest.new(data_source)
    split_test.cohorts.each do |_cohort, cohort_data|
      expect(cohort_data[:conversion_rate]).to be >= 0.0
      expect(cohort_data[:conversion_rate]).to be <= 1.0
    end
  end

  it 'should return a number between -1 and 1 to represent each of the two error bars' do
    split_test = SplitTest.new(data_source)
    split_test.cohorts.each do |_cohort, cohort_data|
      expect(cohort_data[:error_bars][0]).to be >= -1.0
      expect(cohort_data[:error_bars][1]).to be <= 1.0
    end
  end

  it 'should return a number between 0 and 1 to represent the confidence level' do
    split_test = SplitTest.new(data_source)
    split_test.cohorts.each do |_cohort, cohort_data|
      expect(cohort_data[:confidence]).to be >= 0.0
      expect(cohort_data[:confidence]).to be <= 1.0
    end
  end
end
