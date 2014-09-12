require "spec_helper"
require_relative "../data"

describe Data do
  describe "#initialize" do
    it "must have a cohort name" do
      data = Data.new(cohort: "A", result: 0)
      expect(data.cohort).to be("A")
    end

    it "raises an error if no cohort name" do
      expect { data = Data.new }.to raise_error
    end

    it "has a conversion factor of 0 or 1" do
      data0 = Data.new(cohort: "A", result: 0)
      data1 = Data.new(cohort: "A", result: 1)
      expect(data0.result).to be(0)
      expect(data1.result).to be(1)
    end

    it "cannot have a conversion besides 0 or 1" do
      expect { Data.new(cohort: "A", result: 3) }.to raise_error
      expect { Data.new(cohort: "A", result: -1) }.to raise_error
      expect { Data.new(cohort: "A", result: 0.5) }.to raise_error
    end
  end
end
