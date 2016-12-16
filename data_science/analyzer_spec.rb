require 'rspec'
require_relative './analyzer.rb'

describe Analyzer do
  let(:test_file_name) { 'test_data.json' }
  let(:analyzer) { Analyzer.new(test_file_name) }

  describe '#initialize' do
    it 'sets the file name and returns an instance' do
      expect(analyzer).to be_a(Analyzer)
      expect(analyzer.file_name).to eq(test_file_name)
    end
  end

  describe 'loading data from file' do
    let(:data) { analyzer.load_raw_data_from_file }
    let(:cohort_data) { analyzer.load_cohort_data(data) }
    let(:cohorts) { analyzer.build_cohort_array(cohort_data) }

    context '#load_raw_data_from_file' do
      it 'has 48 data points' do
        expect(data.count).to eq(48)
      end
    end

    context '#load_cohort_data' do
      it 'builds a hash to group the data' do
        expect(cohort_data).to be_a(Hash)
      end

      it 'groups data under the cohort names' do
        expect(cohort_data.keys).to eq(%w(B A))
      end
    end

    describe '#build_cohort_array' do
      it 'creates an array of two cohort objects' do
        expect(cohorts.count).to eq(2)
        expect(cohorts).to be_a(Array)
        expect(cohorts[0]).to be_a(Cohort)
        expect(cohorts[1]).to be_a(Cohort)
      end
    end
  end

  describe '#initialize_test' do
    let(:tester) { analyzer.initialize_test }

    it 'creates an ABAnalyzer::ABTest instance' do
      expect(tester).to be_a(ABAnalyzer::ABTest)
    end
  end

  describe '#perform_experiment' do
    it 'calculates a p-value of ' do
      expect(analyzer.perform_experiment).to be_within(0.01).of(0.551)
    end
  end
end
