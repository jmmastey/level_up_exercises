require_relative './spec_helper'
require_relative '../data_analyzer'

describe 'DataAnalyzer' do
  let(:data_small) { TestDataFactory.small_sample }
  let(:data_invalid_key) { TestDataFactory.invalid_key_sample }
  let(:data_invalid_value) { TestDataFactory.invalid_value_sample }
  let(:data_confident) { TestDataFactory.confident_sample }
  let(:data_inconclusive) { TestDataFactory.inconclusive_sample }
  let(:data_ninety_percent) { TestDataFactory.ninety_percent_sample }

  it "should accept and store a data set on instantiation" do
    analyisis = DataAnalyzer.new(data_small)
    expect(analyisis.dataset).to eq(data_small)
  end

  it "should raise an exception if the data entries do not contain keys :cohort and :result" do
    expect { DataAnalyzer.new(data_invalid_key) }.to raise_exception
  end

  it "should raise an exception if the value in a data entry's :result are not 0 or 1" do
    expect { DataAnalyzer.new(data_invalid_value) }.to raise_exception
  end

  describe "#sample_size" do
    it "should return the correct sample size for a given cohort" do
      analysis = DataAnalyzer.new(data_small)
      expect(analysis.sample_size("A")).to eq(20)
      expect(analysis.sample_size("B")).to eq(30)
    end

    it "should return 0 for a cohort that does not exist in the dataset" do
      analysis = DataAnalyzer.new(data_small)
      expect(analysis.sample_size("X")).to eq(0)
    end
  end

  describe "#num_conversions" do
    it "should return the correct number of conversions for a given cohort" do
      analysis = DataAnalyzer.new(data_small)
      expect(analysis.num_conversions("A")).to eq(8)
      expect(analysis.num_conversions("B")).to eq(10)
    end

    it "should return 0 for a cohort that does not exist in the dataset" do
      analysis = DataAnalyzer.new(data_small)
      expect(analysis.num_conversions("X")).to eq(0)
    end
  end

  describe "#conversion_rate" do
    it "should return the correct conversion rate and deviation for a given cohort" do
      analysis = DataAnalyzer.new(data_small)
      expect(analysis.conversion_rate("A")[:rate]).to eq(0.4)
      expect(analysis.conversion_rate("A")[:deviation]).to eq(0.21)
      expect(analysis.conversion_rate("B")[:rate]).to eq(0.33)
      expect(analysis.conversion_rate("B")[:deviation]).to eq(0.17)
    end

    it "should return 0 for conversion rate and deviation if the given cohort does not exist within the dataset" do
      analysis = DataAnalyzer.new(data_small)
      expect(analysis.conversion_rate("X")[:rate]).to eq(0)
      expect(analysis.conversion_rate("X")[:deviation]).to eq(0)
    end
  end

  describe "#conclusive?" do
    it "should return true if the chi-sqaure p-value is equal to or greater than a 95% certainty" do
      conclusive = DataAnalyzer.new(data_confident)
      expect(conclusive.conclusive?).to be(true)
    end

    it "should return false if the chi-sqaure p-value is less than a 95% certainty" do
      inconclusive = DataAnalyzer.new(data_inconclusive)
      expect(inconclusive.conclusive?).to be(false)
    end

    it "should accept a precision value between 0 and 1 and return true/false against the given precision" do
      ninety_percent = DataAnalyzer.new(data_ninety_percent)
      expect(ninety_percent.conclusive?).to be(false)
      expect(ninety_percent.conclusive?(0.9)).to be(true)
    end

    it "should raise an exception if the precision passed in is not between 0 and 1" do
      analysis = DataAnalyzer.new(data_small)
      expect { analysis.conclusive?(-1) }.to raise_exception
      expect { analysis.conclusive?(2) }.to raise_exception
    end
  end
end
