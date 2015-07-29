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
    let(:cohorts) { analyzer.load_cohorts_from_data }

    it 'creates an array of cohort objects' do
      expect(cohorts.count).to eq(2)
      expect(cohorts[0]).to be_a(Cohort)
      expect(cohorts[1]).to be_a(Cohort)
    end
  end

  describe '#perform_experiment' do
    it 'calculates a p-value for the Chi-squared test' do
      expect(analyzer.perform_experiment).to be_within(0.01).of(0.551)
    end
  end
end
