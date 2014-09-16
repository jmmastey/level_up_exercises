require "rspec"

require_relative "../confidenceinterval"

describe ConfidenceInterval do
  context "upon recieving data" do
    let(:raw_data) do
      %q([{"date":"2014-03-15","cohort":"B","result":1},
          {"date":"2014-03-20","cohort":"B","result":1},
          {"date":"2014-03-20","cohort":"B","result":0},
          {"date":"2014-03-17","cohort":"B","result":0}])
    end

    let(:data) do
      ViewParser.new.parse(raw_data)
    end

    let(:interval) do
      ConfidenceInterval.new(id: "A", data: data,
         result_field: :purchased, confidence_level: 0.95)
    end

    it "should be able to calculate the standard deviation" do
      expect(interval.standard_deviation).to eq(0.25)
    end

    it "should be able to calculate the low point" do
      expect(interval.low_point).to eq(0.5 - 1.96 * 0.25)
    end

    it "should be able to calculate the high point" do
      expect(interval.high_point).to eq(0.5 + 1.96 * 0.25)
    end
  end
end
