require_relative '../data_analyzer'
require_relative '../error/format_error'

test_small = {
  "A" => { conversions: 8, non_conversions: 12 },
  "B" => { conversions: 10, non_conversions: 20 },
}

describe "DataAnalyzer" do
  let(:analysis) { DataAnalyzer.new(test_small) }

  it "should accept and store a data set on instantiation" do
    expect(analysis.dataset).to eq(test_small)
  end

  context "data format is incorrect" do
    it "should raise if not a hash" do
      test_data = ["A", { conversions: 8, non_conversions: 12 }]
      expect { DataAnalyzer.new(test_data) }.to raise_error(FormatError)
    end

    it "should raise if values are not hashes" do
      test_data = { "A" => ["conversions", 8, "non_conversions", 12] }
      expect { DataAnalyzer.new(test_data) }.to raise_error(FormatError)
    end

    it "should raise if values do not contain :conversions" do
      test_data = { "A" => { non_conversions: 12 } }
      expect { DataAnalyzer.new(test_data) }.to raise_error(FormatError)
    end

    it "should raise if values do not contain :non_conversions" do
      test_data = { "A" => { conversions: 8 } }
      expect { DataAnalyzer.new(test_data) }.to raise_error(FormatError)
    end

    it "should raise if result hash does not contain integers" do
      test_data = {
        "A" => { conversions: "eight", non_conversions: "twelve" },
      }
      expect { DataAnalyzer.new(test_data) }.to raise_error(FormatError)
    end
  end

  describe "#conversion_rate" do
    it "should return the correct conversion rate and deviation" do
      expect(analysis.conversion_rate("A")[:rate]).to eq(0.4)
      expect(analysis.conversion_rate("A")[:deviation]).to eq(0.21)
      expect(analysis.conversion_rate("B")[:rate]).to eq(0.33)
      expect(analysis.conversion_rate("B")[:deviation]).to eq(0.17)
    end
  end

  describe "#conclusive?" do
    context "results are conclusive at a 95% or greater certainty" do
      let(:data_confident) do
        {
          "A" => { conversions: 225, non_conversions: 275 },
          "B" => { conversions: 450, non_conversions: 50 },
        }
      end

      it "should return true" do
        conclusive = DataAnalyzer.new(data_confident)
        expect(conclusive.conclusive?).to be(true)
      end
    end

    context "results are inconclusive at a 95% or greater certainty" do
      let(:data_inconclusive) do
        {
          "A" => { conversions: 225, non_conversions: 275 },
          "B" => { conversions: 230, non_conversions: 270 },
        }
      end

      it "should return false" do
        inconclusive = DataAnalyzer.new(data_inconclusive)
        expect(inconclusive.conclusive?).to be(false)
      end
    end

    context "precision parameter is passed in" do
      let(:data_ninety_percent) do
        {
          "A" => { conversions: 225, non_conversions: 275 },
          "B" => { conversions: 255, non_conversions: 245 },
        }
      end
      let(:analysis) { DataAnalyzer.new(data_ninety_percent) }

      it "return true/false against the given precision" do
        expect(analysis.conclusive?).to be(false)
        expect(analysis.conclusive?(0.9)).to be(true)
      end

      it "should raise an exception if the precision is out of range" do
        expect { analysis.conclusive?(-1) }.to raise_error(RangeError)
        expect { analysis.conclusive?(2) }.to raise_error(RangeError)
      end
    end
  end
end
