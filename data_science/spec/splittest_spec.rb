require './splittest'

describe SplitTest do
  FILEPATH_DATA = './data/'
  DATA_SOURCES = {
    invalid: FILEPATH_DATA + 'invalid.json',
    nonexistant: FILEPATH_DATA + 'nonexistant.json',
    small_sample: FILEPATH_DATA + 'test_data_small_sample.json',
    test: FILEPATH_DATA + 'test_data.json',
    wrong_format: FILEPATH_DATA + 'test_data_wrong_format.json',
  }

  describe 'initializing without specifying a data source' do
    before(:example) do
      @split_test = SplitTest.new
    end

    describe 'and then not providing a data source upon generating a report' do
      it 'should raise a NoDataSourceError' do
        expect do
          @split_test.generate_report
        end.to raise_error(SplitTest::NoDataSourceError)
      end
    end

    describe 'and then providing a non-existant data source upon generating a report' do
      it 'should raise a FileNotFoundError' do
        expect do
          @split_test.generate_report(DATA_SOURCES[:nonexistant])
        end.to raise_error(SplitTest::FileNotFoundError)
      end
    end

    describe 'and then providing a data source in the wrong format upon generating a report' do
      it 'should raise an InvalidDataFormatError' do
        expect do
          @split_test.generate_report(DATA_SOURCES[:wrong_format])
        end.to raise_error(SplitTest::InvalidDataFormatError)
      end
    end

    describe 'and then providing data that is not valid JSON' do
      it 'should raise an InvalidDataFormatError' do
        expect do
          @split_test.generate_report(DATA_SOURCES[:wrong_format])
        end.to raise_error(SplitTest::InvalidDataFormatError)
      end
    end

    describe 'and then providing a data set that is too small' do
      it 'should raise an InsufficientDataError' do
        expect do
          @split_test.generate_report(DATA_SOURCES[:small_sample])
        end.to raise_error(SplitTest::InsufficientDataError)
      end
    end
  end

  describe 'using predefined test data' do

    before(:example) do
      @split_test = SplitTest.new(DATA_SOURCES[:test])
      @split_test.generate_report
    end

    it 'should return a total of 50 when we add up the "yes" and "no" answers from each cohort' do
      total = 0
      @split_test.cohorts.each do |_cohort_name, cohort|
        total += cohort.yes + cohort.no
      end
      expect(total).to eq(50)
    end

    it 'should return a conversion rate of 0.2307692308 for "A"' do
      expect(@split_test.cohorts[:a].conversion_rate).to eq(0.2307692308)
    end

    it 'should return a conversion rate of 0.2307692308 for "B"' do
      expect(@split_test.cohorts[:b].conversion_rate).to eq(0.4166666667)
    end

    it 'should return a number between -1 and 1 to represent each of the two error bars' do
      @split_test.cohorts.each do |_cohort_name, cohort|
        expect(cohort.error_bars[0]).to be >= -1.0
        expect(cohort.error_bars[1]).to be <= 1.0
      end
    end

    it 'should return a number between 0 and 1 to represent the confidence level' do
      expect(@split_test.confidence).to be_between(0.0, 1.0).inclusive
    end
  end
end
