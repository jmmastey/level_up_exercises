require_relative 'data_science'

describe Optimizer do
  before :each do
    @optimizer = Optimizer.new 'test_data.json'
  end

  describe "simple_counts" do
    it "counts total sample size per cohort" do
      expect(@optimizer.simple_counts[:A][:sample_size]).to eq(28)
      expect(@optimizer.simple_counts[:B][:sample_size]).to eq(14)
    end

    it "counts number of conversions per cohort" do
      expect(@optimizer.simple_counts[:A][:conversions]).to eq(12)
    end
  end

  describe "calculations" do
    it "should calculate conversion rates" do
      result = @optimizer.conversion_rates
      expect(result[:A].class).to eq(Array)
      expect(result[:A][0]).to be < result[:A][1]
    end

    it "should do chisquared calculations" do
      expect(@optimizer.result_confidence).to be < 1
    end
  end
end
