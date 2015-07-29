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

  describe '#calculate_statistics' do
    before { cohort.calculate_statistics }

    it 'calculates the conversion rate' do
      expect(cohort.conversion_rate).to be_within(0.01).of(0.416)
    end

    it 'calculates lower confidence interval' do
      expect(cohort.lower_confidence_interal).to be_within(0.01).of(0.21882)
    end

    it 'calculates upper confidence interval' do
      expect(cohort.upper_confidence_interval).to be_within(0.01).of(0.6132)
    end
  end

  describe '#conversion_statistics' do
    let(:stats) { cohort.conversion_statistics }

    it 'creates a hash of conversions and non-conversions' do
      expect(stats[:conversions]).to eq(10)
      expect(stats[:non_conversions]).to eq(14)
    end
  end

  describe '#summary' do
    before do
      cohort.calculate_statistics
      @output = cohort.summary
    end

    it 'includes the cohort name' do
      expect(@output).to include('Cohort: A')
    end

    it 'includes the sample proportions' do
      expect(@output).to include('(10 out of 24 visits)')
    end
  end
end
