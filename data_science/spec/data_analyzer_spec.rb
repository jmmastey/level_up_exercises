require_relative './spec_helper'
require_relative '../data_analyzer'

describe 'DataAnalyzer' do
  let(:data) { TestDataFactory.small_sample }

  before :each do
    @analysis = DataAnalyzer.new(data)
  end

  it "should accept and store a dataset on instantiation" do
    expect(@analysis.dataset).to eq(data)
  end

  context "data entries do not contain expected keys" do
    let(:data_invalid_cohort) { TestDataFactory.invalid_cohort_sample }
    let(:data_invalid_result) { TestDataFactory.invalid_result_sample }

    it "should raise an exception if key :cohort is missing" do
      expect { DataAnalyzer.new(data_invalid_cohort) }.to raise_exception
    end

    it "should raise an exception if key :result is missing" do
      expect { DataAnalyzer.new(data_invalid_result) }.to raise_exception
    end
  end

  context "dataset :result values are not between 0 and 1" do
    let(:data_invalid_value) { TestDataFactory.invalid_value_sample }

    it "should raise an exception if :result values are out of range" do
      expect { DataAnalyzer.new(data_invalid_value) }.to raise_exception
    end
  end

  describe "#sample_size" do
    it "should return the correct sample size for a given cohort" do
      expect(@analysis.sample_size("A")).to eq(20)
      expect(@analysis.sample_size("B")).to eq(30)
    end

    it "should return 0 for a cohort that does not exist in the dataset" do
      expect(@analysis.sample_size("X")).to eq(0)
    end
  end

  describe "#num_conversions" do
    it "should return the correct number of conversions for a given cohort" do
      expect(@analysis.num_conversions("A")).to eq(8)
      expect(@analysis.num_conversions("B")).to eq(10)
    end

    it "should return 0 for a cohort that does not exist in the dataset" do
      expect(@analysis.num_conversions("X")).to eq(0)
    end
  end

  describe "#conversion_rate" do
    it "should return the correct conversion rate and deviation" do
      expect(@analysis.conversion_rate("A")[:rate]).to eq(0.4)
      expect(@analysis.conversion_rate("A")[:deviation]).to eq(0.21)
      expect(@analysis.conversion_rate("B")[:rate]).to eq(0.33)
      expect(@analysis.conversion_rate("B")[:deviation]).to eq(0.17)
    end

    context "cohort parameter is not found within the dataset" do
      it "should return 0 for conversion rate and deviation" do
        expect(@analysis.conversion_rate("X")[:rate]).to eq(0)
        expect(@analysis.conversion_rate("X")[:deviation]).to eq(0)
      end
    end
  end

  describe "#conclusive?" do
    context "results are conclusive at a 95% or greater certainty" do
      let(:data_confident) { TestDataFactory.confident_sample }

      it "should return true" do
        conclusive = DataAnalyzer.new(data_confident)
        expect(conclusive.conclusive?).to be(true)
      end
    end

    context "results are inconclusive at a 95% or greater certainty" do
      let(:data_inconclusive) { TestDataFactory.inconclusive_sample }

      it "should return false" do
        inconclusive = DataAnalyzer.new(data_inconclusive)
        expect(inconclusive.conclusive?).to be(false)
      end
    end

    context "precision parameter is passed in" do
      let(:data_ninety_percent) { TestDataFactory.ninety_percent_sample }

      it "return true/false against the given precision" do
        ninety_percent = DataAnalyzer.new(data_ninety_percent)
        expect(ninety_percent.conclusive?).to be(false)
        expect(ninety_percent.conclusive?(0.9)).to be(true)
      end

      it "should raise an exception if the precision is out of range" do
        expect { @analysis.conclusive?(-1) }.to raise_exception
        expect { @analysis.conclusive?(2) }.to raise_exception
      end
    end
  end
end
