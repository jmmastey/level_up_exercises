require_relative "spec_helper.rb"
describe Cohort do
  TEST_FILE = 'test_data_b.json'
  let(:data_parser) { DataParser.new(TEST_FILE) }
  let(:cohort_a) { Cohort.new(data_parser.cohort_a) }
  let(:cohort_b) { Cohort.new(data_parser.cohort_b) }

  it 'returns number of conversions for cohort A' do
    expect(cohort_a.conversions).to eq(21)
  end

  it 'returns number of non conversions for cohort A' do
    expect(cohort_a.non_conversions).to eq(529)
  end

  it 'returns total sample size for cohort A' do
    expect(cohort_a.total_sample_size).to eq(550)
  end

  it 'calculates and returns conversion rate for cohort A' do
    expect(cohort_a.conversion_rate).to eq(0.0382)
  end

  it 'returns standard error for coversion rate for cohort A' do
    conversion_rate = cohort_a.conversion_rate
    expect(cohort_a.std_err(conversion_rate)).to eq(0.0082)
  end

  it 'returns error bars for conversion rate for cohort A' do
    expect(cohort_a.error_bars).to eq([0.0543, 0.0221])
  end

  it 'returns number of conversions for cohort B' do
    expect(cohort_b.conversions).to eq(41)
  end

  it 'returns number of non conversions for cohort B' do
    expect(cohort_b.non_conversions).to eq(593)
  end

  it 'returns total sample size for cohort B' do
    expect(cohort_b.total_sample_size).to eq(634)
  end

  it 'calculates and returns conversion rate for cohort B' do
    expect(cohort_b.conversion_rate).to eq(0.0647)
  end

  it 'returns standard error for cohort B' do
    conversion_rate = cohort_b.conversion_rate
    expect(cohort_b.std_err(conversion_rate)).to eq(0.0098)
  end

  it 'returns error bars for conversion rate for cohort B' do
    expect(cohort_b.error_bars).to eq([0.0839, 0.0455])
  end
end
