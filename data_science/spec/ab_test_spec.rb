require_relative '../ab_test'
require_relative '../cohort'
require 'json'

describe "let" do
  let(:leading_cohort_name) { :B }
  let(:confidence_in_leader) { 0.3640661012729629 }
  all_data = JSON.parse(File.read('smaller_data_set.json'))
  let(:pop_a) { all_data.select { |record| record["cohort"] == "A" } }
  let(:pop_b) { all_data.select { |record| record["cohort"] == "B" } }
  let(:cohort_a) { Cohort.new(pop_a) }
  let(:cohort_b) { Cohort.new(pop_b) }
  let(:ab_test) { ABtest.new(cohort_a, cohort_b) }

  describe ABtest do
    describe("#new") do
      it "takes 2 cohorts and returns and ABtest object" do
        expect(ab_test).to(be_an_instance_of(ABtest))
      end
      it "has 2 instance variables, cohort_A, cohort_B of type Cohort" do
        expect(ab_test.cohort_a).to(be_an_instance_of(Cohort))
        expect(ab_test.cohort_b).to(be_an_instance_of(Cohort))
      end
    end

    it "finds the leader in conversion rates" do
      expect(ab_test.leader).to(eql(leading_cohort_name))
    end

    it "determines confidence that leader is actually the leader" do
      leader_confidence = ab_test.compute_leader_confidence_level
      expect(leader_confidence).to(be_within(0.0001).of(confidence_in_leader))
    end
  end
end
