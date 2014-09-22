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
      @ds.all_data.each_key do |k|
        puts @ds.error_bars(k).length
      end

    end

    it "should have a valid p-value" do

    end

    it "should have a valid chi-square value" do

    end
  end
end
