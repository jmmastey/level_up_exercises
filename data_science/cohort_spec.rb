require 'rspec'
require 'json'
require_relative './cohort.rb'

describe Cohort do
  let(:test_file_name) { 'test_data.json' }
  let(:data) { JSON.parse(File.read(test_file_name)) }
  let(:cohort_name) { 'A' }
  let(:cohort_data) do
    data.select { |row| row["cohort"] == cohort_name }
      .collect { |row| row["result"] }
  end
  let(:cohort) { Cohort.new(cohort_name, cohort_data) }

  describe '#initialize' do
    it 'sets Cohort instance with its name, 24 data points, and 10 convs' do
      expect(cohort).to be_a(Cohort)
      expect(cohort.name).to eq(cohort_name)
      expect(cohort.sample_size).to eq(24)
      expect(cohort.conversions).to eq(10)
    end
  end

  describe 'calculating statistics' do
    before do
      cohort.calc_conversion_rate
      cohort.calc_standard_error
      cohort.calc_confidence_intervals
    end

    context '#calc_conversion_rate' do
      subject { cohort.conversion_rate }
      it { is_expected.to be_within(0.01).of(0.416) }
    end

    context '#calc_standard_error' do
      subject { cohort.stnd_error }
      it { is_expected.to be_within(0.01).of(0.1006) }
    end

    describe '#calc_confidence_intervals' do
      context '#lower_ci' do
        subject { cohort.lower_ci }
        it { is_expected.to be_within(0.01).of(0.218824) }
      end

      context '#upper_ci' do
        subject { cohort.upper_ci }
        it { is_expected.to be_within(0.01).of(0.613176) }
      end
    end
  end

  describe '#conversion_statistics' do
    let(:stats) { cohort.conversion_statistics }

    it 'creates a hash of conversions and non-conversions' do
      expect(stats).to be_a(Hash)
      expect(stats[:conversions]).to eq(10)
      expect(stats[:non_conversions]).to eq(14)
    end
  end
end
