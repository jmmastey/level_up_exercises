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

  describe '#load_data' do
    it 'has exactly 48 data points' do
      expect(analyzer.load_data.count).to eq(48)
    end
  end

  describe '#load_cohort_data' do
    before do
      data = analyzer.load_data
      @cohort_data = analyzer.load_cohort_data(data)
    end

    it 'builds a hash to group the data' do
      expect(@cohort_data).to be_a(Hash)
    end

    it 'groups data under the cohort names' do
      expect(@cohort_data.keys).to eq(%w(B A))
    end
  end

  describe '#build_cohort_array' do
    before do
      data = analyzer.load_data
      cohort_data = analyzer.load_cohort_data(data)
      @cohorts = analyzer.build_cohort_array(cohort_data)
    end

    it 'creates an array of two cohort objects' do
      expect(@cohorts.count).to eq(2)
      expect(@cohorts).to be_a(Array)
      expect(@cohorts[0]).to be_a(Cohort)
      expect(@cohorts[1]).to be_a(Cohort)
    end
  end
end
