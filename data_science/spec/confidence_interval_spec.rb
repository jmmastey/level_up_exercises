require "rspec"

require_relative "../confidence_interval"

describe ConfidenceInterval do
  context "upon recieving statistics" do
    let(:interval) do
      ConfidenceInterval.new(success_count: 2,
         fail_count: 2, confidence_level: 0.95)
    end

    it "should be able to calculate the standard deviation" do
      expect(interval.standard_deviation).to eq(0.25)
    end

    it "should be able to calculate the low point" do
      expect(interval.low_percent).to eq(0.5 - 1.96 * 0.25)
    end

    it "should be able to calculate the high point" do
      expect(interval.high_percent).to eq(0.5 + 1.96 * 0.25)
    end
  end
end
