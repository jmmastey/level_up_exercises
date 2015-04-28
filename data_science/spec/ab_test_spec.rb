require_relative '../ab_test'
require_relative '../cohort'

COHORT1_NAME = :A
COHORT1_SAMPLE_SIZE = 72
COHORT1_NUM_CONVERSIONS = 5
COHORT2_NAME = :B
COHORT2_SAMPLE_SIZE = 89
COHORT2_NUM_CONVERSIONS = 8

LEADING_COHORT_NAME = :B
CONFIDENCE_IN_LEADER = 0.3640661012729629

describe ABtest do
let(:cohort_a) { Cohort.new(COHORT1_NAME, COHORT1_SAMPLE_SIZE, COHORT1_NUM_CONVERSIONS) }
let(:cohort_b) { Cohort.new(COHORT2_NAME, COHORT2_SAMPLE_SIZE, COHORT2_NUM_CONVERSIONS) }
let(:ab_test) { ABtest.new(cohort_a, cohort_b) }

  describe("#new") do
    it "has 2 instance variables, cohort_A, cohort_B of type Cohort" do
      expect(ab_test.cohort_a).to(be_an_instance_of(Cohort))
      expect(ab_test.cohort_b).to(be_an_instance_of(Cohort))
    end
  end

  it "finds the leader in conversion rates" do
    expect(ab_test.leader).to(eql(LEADING_COHORT_NAME))
  end

  it "determines confidence that leader is actually the leader" do
    leader_confidence = ab_test.compute_leader_confidence_level
    expect(leader_confidence).to(be_within(0.0001).of(CONFIDENCE_IN_LEADER))
  end
end
