require_relative '../ab_compare'
require_relative '../cohort'

COHORT1_NAME = :A
COHORT1_SAMPLE_SIZE = 72
COHORT1_NUM_CONVERSIONS = 5
COHORT2_NAME = :B
COHORT2_SAMPLE_SIZE = 89
COHORT2_NUM_CONVERSIONS = 8

LEADING_COHORT_NAME = :B
CONFIDENCE_IN_LEADER = 0.3640661012729629

describe ABCompare do
  let(:cohort_a) { Cohort.new(COHORT1_NAME, COHORT1_SAMPLE_SIZE, COHORT1_NUM_CONVERSIONS) }
  let(:cohort_b) { Cohort.new(COHORT2_NAME, COHORT2_SAMPLE_SIZE, COHORT2_NUM_CONVERSIONS) }
  let(:ab_compare) { ABCompare.new(cohort_a, cohort_b) }

  describe("#ABCompare object") do
    it "contains 2 cohorts objects" do
      expect(ab_compare.cohort_a).to(be_an_instance_of(Cohort))
      expect(ab_compare.cohort_b).to(be_an_instance_of(Cohort))
    end

    it "has a method to find which of the 2 cohorts has highest conversion rate" do
      expect(ab_compare.leader).to(eql(LEADING_COHORT_NAME))
    end

    it "has a method to determine how confident you can be that the leader is a statistically significant leader" do
      leader_confidence = ab_compare.compute_leader_confidence_level
      expect(leader_confidence).to(be_within(0.0001).of(CONFIDENCE_IN_LEADER))
    end
  end
end
