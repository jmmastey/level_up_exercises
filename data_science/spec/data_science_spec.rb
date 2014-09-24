require 'spec_helper'

describe 'Data Science' do

  context "Parser" do
    before :all do
      @parser = ParseJsonFile.new
      @parser.load_json_file("source_data.json")
    end

    it "should parse a json file correctly" do
      expect(@parser.data.first).to include(:cohort)
    end

    it "should parse and group the json file by cohort" do
      expect(@parser.group_data_by_cohort.length).to eql(2)
    end
  end

  context "Calculation" do
    before :all do
      @ds = DataScience.new("source_data.json")
      @calculation = @ds.perform_all_calculations
    end

    it "should return a correct total sample size" do
      totals = 0
      @ds.all_data.each_key { |k| totals = totals + @ds.cohort_sample_size(k) }
      expect(totals).to be_within(10).of(2900)
    end

    it "should have a correct number of conversions" do
      totals = 0
      @ds.all_data.each_key { |k| totals = totals + @ds.all_conversions(k) }
      expect(totals).eql?(126)
    end

    it "should have a correct percentage of conversions" do
      @ds.all_data.each_key do |k|
        expect(@ds.conversion_percentage(k)).to be_within(0.02).of(0.05)
      end
    end

    it "should have the correct amount of error bars for each cohort" do
      expect(@calculation["A"][:error_bars].length).to eql(2)
      expect(@calculation["B"][:error_bars].length).to eql(2)
    end

    it "should have a valid p-value" do
      expect(@calculation[:pvalue]).to_not be_nil
    end

    it "should have a valid chi-square value" do
      expect(@calculation[:chi_square]).to_not be_nil
      expect(@calculation[:chi_square]).to be_within(1).of(4)
    end
  end

  context "Invalid Data" do
    before :all do
      @ds = DataScience.new("spec/mock_json.json")
    end

    it "should throw a Insufficient Data error" do
      expect {
        @ds.perform_all_calculations
      }.to raise_error
    end
  end
end
