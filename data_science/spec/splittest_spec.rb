require './splittest'
require './splittest_exceptions'
require 'pry'

describe SplitTest do
  FILEPATH_DATA = './data/'
  DATA_SOURCES = {
    invalid: FILEPATH_DATA + 'invalid.json',
    nonexistant: FILEPATH_DATA + 'nonexistant.json',
    test: FILEPATH_DATA + 'test_data.json',
    wrong_format: FILEPATH_DATA + 'test_data_wrong_format.json',
  }

  subject(:test) { described_class.new }
  let(:report) { test.generate_report(DATA_SOURCES[:test]) }

  describe '#generate_report' do

    context 'invalid data' do
      it 'should raise a InvalidDataFormatError exception' do
        expect do
          test.generate_report(DATA_SOURCES[:invalid])
        end.to raise_error(Exceptions::InvalidDataFormatError)
      end
    end

    context 'nonexistant data' do
      it 'should raise a FileNotFoundError exception' do
        expect do
          test.generate_report(DATA_SOURCES[:nonexistant])
        end.to raise_error(Exceptions::FileNotFoundError)
      end
    end

    context 'incorrectly formatted data' do
      it 'should raise an InvalidDataFormatError exception' do
        expect do
          test.generate_report(DATA_SOURCES[:wrong_format])
        end.to raise_error(Exceptions::InvalidDataFormatError)
      end
    end
  end

  describe '#confidence' do
    context 'before we generate a report' do
      it 'should raise an NoDataSourceError exception' do
        expect do
          test.confidence
        end.to raise_error(Exceptions::NoDataSourceError)
      end
    end

    context 'after we generate a report' do
      it 'should return a number between 0 and 1 to represent the confidence level' do
        expect(report.confidence).to be_between(0.0, 1.0).inclusive
      end
    end
  end

  context 'a generated report' do
    it 'should return a total of 50 when we add up the "yes" and "no" answers from each cohort' do
      total = 0
      report.cohorts.each do |_cohort_name, cohort|
        total += cohort.yes + cohort.no
      end
      expect(total).to eq(50)
    end

    it 'should return a conversion rate of 0.2307692308 for "A"' do
      expect(report.cohorts[:a].conversion_rate).to eq(0.2307692308)
    end

    it 'should return a conversion rate of 0.2307692308 for "B"' do
      expect(report.cohorts[:b].conversion_rate).to eq(0.4166666667)
    end

    it 'should return a number between -1 and 1 to represent each of the two error bars' do
      report.cohorts.each do |_cohort_name, cohort|
        expect(cohort.error_bars[0]).to be >= -1.0
        expect(cohort.error_bars[1]).to be <= 1.0
      end
    end
  end
end
