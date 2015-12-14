require './data_science'
require './json_io'
require 'spec_helper'

RSpec.describe DataScience do
  let(:data_science) do
    data = JsonIO.new("./test_data.json").read
    DataScience.new(data)
  end

  let(:actual_confidence) { data_science.confidence }

  let(:actual_chisquare) do
    actual = data_science.chi_square
    actual.map! { |f| f.round(3) }
  end

  describe "#significant?" do
    it "should calculate a small sample and return false" do
      expect(data_science).not_to be_significant
    end
  end

  describe "#count" do
    it "should count the number of conversions for cohort B" do
      expect(data_science.count(category("B", 1))).to eq(14)
    end
    it "should count the number of conversions for cohort A" do
      expect(data_science.count(category("A", 1))).to eq(7)
    end
    it "should count the number of trials for cohort B" do
      expect(data_science.count(category("B"))).to eq(35)
    end
    it "should count the number of unknown values for cohort A" do
      expect(data_science.count(category("A", 99))).to eq(0)
    end
  end

  describe "#sample_size" do
    it "should return a hash of total group counts" do
      expected = { "Total" => 70, "A" => 35, "B" => 35 }
      expect(data_science.sample_size).to be == expected
    end
  end

  describe "#conversions" do
    it "should return a hash of conversions for each cohort" do
      expected = { "A" => 7, "B" => 14 }
      expect(data_science.conversions).to be == expected
    end
  end

  describe "#confidence" do
    it "should return a 95% confidence range for success rates" do
      expect(actual_confidence["A"][0].round(3)).to be == 0.067
      expect(actual_confidence["A"][1].round(3)).to be == 0.333
      expect(actual_confidence["B"][0].round(3)).to be == 0.238
      expect(actual_confidence["B"][1].round(3)).to be == 0.562
    end
  end

  describe "#chi_square" do
    it "return the score and p values of the chi-square test" do
      expect(actual_chisquare).to be == [3.333, 0.068]
    end
  end
end
