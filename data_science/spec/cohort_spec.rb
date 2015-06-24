require 'spec_helper'

describe Cohort do
  let(:group_a) { { "A" => { conversions: 340, non_conversions: 320 } } }
  let(:cohort_a) { Cohort.new(group_a) }

  describe "#name" do
    it "knows its name" do
      expect(cohort_a.name).to eq "A"
    end
  end

  describe "#conversions" do
    it "records its given conversions" do
      expect(cohort_a.conversions).to eq 340
    end
  end

  describe "#non_conversions" do
    it "records its given nonconversions" do
      expect(cohort_a.non_conversions).to eq 320
    end
  end

  describe "#sample_size" do
    it "knows its sample size" do
      expect(cohort_a.sample_size).to eq 660
    end
  end

  describe "#calculate_conversion_rate" do
    it "knows its conversion rate" do
      expect(cohort_a.calculate_conversion_rate).to eq 0.52
    end
  end

  describe "#calculate_confidence_interval" do
    it "knows its confidence interval" do
      expect(cohort_a.calculate_confidence_interval).to eq [0.47702328622933254, 0.5532797440736977]
    end
  end
end
