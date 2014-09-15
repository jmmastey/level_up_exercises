require "rspec"

require_relative "../confidenceinterval"

describe ConfidenceInterval do
  context "upon creation" do
    let(:easy_interval) do
      ConfidenceInterval.new(
        probability_of_success: 0.5,
        observation_size: 4,
        confidence_level: 0.95
      )
    end

    let(:hard_interval) do
      ConfidenceInterval.new(
        probability_of_success: 0.8,
        observation_size: 1,
        confidence_level: 0.95
      )
    end

    it "should be able to calculate the standard deviation" do
      expect(easy_interval.standard_deviation).to eq(0.25)
      expect(hard_interval.standard_deviation).to eq((0.8 * (1 - 0.8))**0.5)
    end
  end
end
