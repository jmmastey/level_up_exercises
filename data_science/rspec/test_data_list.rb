require_relative '../test_data'

describe TestData do
  context "happy" do
    let(:filepath) { 'test_data.json' }
    subject(:test_data) { TestData.new(filepath).data }

    it "should parse a json file of test result data" do
      expect(test_data).not_to be_empty
    end

    it "should not have any results without a cohort" do
      expect(test_data.select { |result| result.cohort.nil? }).to be_empty
    end

    it "should not have any results without a date" do
      expect(test_data.select { |result| result.date.nil? }).to be_empty
    end

    it "should not have any results without a result" do
      expect(test_data.select { |result| result.result.nil? }).to be_empty
    end
  end

  context "sad" do
    let(:filepath) { 'fake.file' }

    it "should raise an error is the file does not exist" do
      expect { Calculator.new(filepath) }.to raise_error
    end
  end
end
