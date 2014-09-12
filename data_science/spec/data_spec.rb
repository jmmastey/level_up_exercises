require "spec_helper"
require_relative "../data"

describe Data do
  describe "#initialize" do
    it "must have a cohort name" do
      data = Data.new("A", 0)
      expect(data.cohort).to be("A")
    end

    it "raises an error if no cohort name" do
      expect { Data.new }.to raise_error ArgumentError
    end

    it "has a conversion factor of 0 or 1" do
      data0 = Data.new("A", 0)
      data1 = Data.new("A", 1)
      expect(data0.result).to be(0)
      expect(data1.result).to be(1)
    end

    it "cannot have a conversion besides 0 or 1" do
      expect { Data.new("A", 3) }.to raise_error ArgumentError
      expect { Data.new("A", -1) }.to raise_error ArgumentError
      expect { Data.new("A", 0.5) }.to raise_error ArgumentError
    end
  end
end
