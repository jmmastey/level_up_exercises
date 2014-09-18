require 'spec_helper'

describe 'Data Science' do
  before :all do
    @parser = ParseJsonFile.new("source_data.json")
  end

  context "Parser" do
    it "should parse a json file correctly" do
      expect(@parser.data.first).to include(:cohort)
    end

    it "should parse and group the json file by cohort" do
      expect(@parser.data.length).to eql(2)
    end

    it "should return correct length for both cohorts" do

    end

  end

  context "Calculation" do
    it "should return a correct total sample size" do

    end

    it "should have a correct number of conversions" do

    end

    it "should have a correct percentage of conversions" do

    end

    it "should have the correct confidence level" do

    end
  end
end
