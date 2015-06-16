require 'spec_helper'

describe Cohort do
  let(:group_a) { { "A" => { conversions: 340, non_conversions: 320 } } }
  let(:group_b) { { "B" => { conversions: 380, non_conversions: 348 } } }
  let(:group_c) { { "C" => { conversions: 1000, non_conversions: 6 } } }
  let(:cohort_a) { Cohort.new(group_a) }
  let(:cohort_b) { Cohort.new(group_b) }
  let(:cohort_c) { Cohort.new(group_c) }

  describe "#name" do
    it "knows its name" do
      expect(cohort_a.name).to eq "A"
      expect(cohort_b.name).to eq "B"
      expect(cohort_c.name).to eq "C"
    end
  end

  describe "#conversions" do
    it "records its given conversions" do
      expect(cohort_a.conversions).to eq 340
      expect(cohort_b.conversions).to eq 380
      expect(cohort_c.conversions).to eq 1000
    end
  end

  describe "#non_conversions" do
    it "records its given nonconversions" do
      expect(cohort_a.non_conversions).to eq 320
      expect(cohort_b.non_conversions).to eq 348
      expect(cohort_c.non_conversions).to eq 6
    end
  end

  describe "#sample_size" do
    it "knows its sample size" do
      expect(cohort_a.sample_size).to eq 660
      expect(cohort_b.sample_size).to eq 728
      expect(cohort_c.sample_size).to eq 1006
    end
  end

  describe "#calculate_conversion_rate" do
    it "knows its conversion rate" do
      expect(cohort_a.calculate_conversion_rate).to eq 0.52
      expect(cohort_b.calculate_conversion_rate).to eq 0.52
      expect(cohort_c.calculate_conversion_rate).to eq 0.99
    end
  end

  describe "#calculate_confidence_interval" do
    it "knows its confidence interval" do
      expect(cohort_a.calculate_confidence_interval).to eq [0.47702328622933254, 0.5532797440736977]
      expect(cohort_b.calculate_confidence_interval).to eq [0.4856925781577534, 0.5582634657982906]
      expect(cohort_c.calculate_confidence_interval).to eq [0.9892777600401348, 0.998793810536406]
    end
  end
end
