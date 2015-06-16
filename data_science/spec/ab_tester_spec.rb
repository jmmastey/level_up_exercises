require 'spec_helper'

describe ABTester do
  let(:group_a) { { "A" => { conversions: 340, non_conversions: 320 } } }
  let(:cohort_a) { Cohort.new(group_a) }
  let(:group_b) { { "B" => { conversions: 380, non_conversions: 348 } } }
  let(:cohort_b) { Cohort.new(group_b) }
  let(:group_c) { { "C" => { conversions: 1000, non_conversions: 6 } } }
  let(:cohort_c) { Cohort.new(group_c) }

  let(:abtest_a) { ABTester.new([cohort_a, cohort_b]) }
  let(:abtest_b) { ABTester.new([cohort_a, cohort_b, cohort_c]) }

  describe "#calculate_better_than_random" do
    it "knows when the leader is better than random" do
      expect(abtest_a.calculate_better_than_random).to eq false
    end

    it "knows when the leader is not better than random" do
      expect(abtest_b.calculate_better_than_random).to eq true
    end
  end
end
