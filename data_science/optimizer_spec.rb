require_relative 'data_science'

describe Optimizer do
  let(:optimizer) { Optimizer.new 'test_data.json' }

  describe "simple_counts" do
    it "counts total sample size per cohort" do
      expect(optimizer.simple_counts[:A][:sample_size]).to eq(28)
      expect(optimizer.simple_counts[:B][:sample_size]).to eq(14)
    end

    it "counts number of conversions per cohort" do
      expect(optimizer.simple_counts[:A][:conversions]).to eq(12)
    end
  end

  describe "calculations" do
    it "should calculate conversion rates" do
      result = optimizer.conversion_rate_for(:A)
      expect(result[0]).to be_within(0.1).of(0.24527)
      expect(result[0]).to be < result[1]
    end

    it "should do chisquared calculations" do
      puts optimizer.result_confidence
      expect(optimizer.result_confidence).to be < 1
      # note this is with sample data.
      # chisquared has been tested against online calculator
    end
  end
end
