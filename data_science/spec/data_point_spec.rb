require "spec_helper"
require_relative "../data_point.rb"

describe DataPoint do
  describe "#initialize" do
    it "has a name and result" do
      data_point = DataPoint.new("A", 1)
      expect(data_point.cohort).to eq("A")
      expect(data_point.result).to eq(1)
    end

    it "raises an error if no name nor result" do
      expect { DataPoint.new("A") }.to raise_error ArgumentError
      expect { DataPoint.new }.to raise_error ArgumentError
    end

    it "must have a result of 0 or 1" do
      expect { DataPoint.new("A", -1) }.to raise_error ArgumentError
      expect { DataPoint.new("A", 0.5) }.to raise_error ArgumentError
      expect { DataPoint.new("A", 3) }.to raise_error ArgumentError
    end
  end

  describe "#converted?" do
    it "subject converted if result is 1" do
      data_point = DataPoint.new("A", 1)
      expect(data_point.converted?).to eq(true)
    end

    it "subject did not convert if result is 0" do
      data_point = DataPoint.new("A", 0)
      expect(data_point.converted?).to eq(false)
    end
  end
end
