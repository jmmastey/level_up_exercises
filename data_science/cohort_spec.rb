require 'rspec'
require 'json'
require_relative './cohort.rb'

describe Cohort do
  let(:test_file_name) { 'test_data.json' }
  let(:data) { JSON.parse(File.read(test_file_name)) }
  let(:cohort_name) { 'A' }
  let(:cohort_data) do
    data.select { |row| row["cohort"] == cohort_name }
      .map { |row| row["result"] }
  end
  let(:cohort) { Cohort.new(cohort_name, cohort_data) }

  describe '#initialize' do
    it 'sets cohort instance with proper name and data' do
      expect(cohort).to be_a(Cohort)
      expect(cohort.name).to eq(cohort_name)
      expect(cohort.sample_size).to eq(24)
      expect(cohort.conversions).to eq(10)
    end
  end

  describe 'calculating statistics' do
    before do
      cohort.calculate_conversion_rate
      cohort.calculate_standard_error
      cohort.calculate_confidence_intervals
    end

    context '#calculate_conversion_rate' do
      it 'calculates correct data' do
        expect(cohort.conversion_rate).to be_within(0.01).of(0.416)
      end
    end

    context '#calculate_standard_error' do
      it 'calculates correct data' do
        expect(cohort.standard_error).to be_within(0.01).of(0.1006)
      end
    end

    describe '#calculate_confidence_intervals' do
      context '#lower_ci' do
        it 'calculates correct data' do
          expect(cohort.lower_confidence_interal).to be_within(0.01).of(0.218824)
        end
      end

      context '#upper_ci' do
        it 'calculates correct data' do
          expect(cohort.upper_confidence_interval).to be_within(0.01).of(0.613176)
        end
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
