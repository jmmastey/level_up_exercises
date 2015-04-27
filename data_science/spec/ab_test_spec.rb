require_relative '../ab_test'

require 'json'

describe "let" do 
  leading_cohort_name = :B
  confidence_in_leader = 0.3640661012729629

  describe ABtest do
    before :all do
      file = File.read('smaller_data_set.json')
      all_data = JSON.parse(file)
      pop_a = all_data.select { |record| record["cohort"] == "A" }
      pop_b = all_data.select { |record| record["cohort"] == "B" }
      cohort_a = Cohort.new(pop_a)
      cohort_b = Cohort.new(pop_b)
      @ab_test = ABtest.new(cohort_a, cohort_b)
    end

    describe("#new") do
      it "takes 2 cohorts and returns and ABtest object" do
        expect(@ab_test).to(be_an_instance_of(ABtest))
      end
      it "has 2 instance variables, cohort_A, cohort_B of type Cohort" do
        expect(@ab_test.cohort_a).to(be_an_instance_of(Cohort))
        expect(@ab_test.cohort_b).to(be_an_instance_of(Cohort))
      end
    end

    it "finds the leader in conversion rates" do
      expect(@ab_test.leader).to(eql(leading_cohort_name))
    end

    describe @ab_test.compute_leader_confidence_level do
      it "determines if there is a signifcant leader" do
      it { should_be_within(0.01).of.(confidence_in_leader) }
    end
  end
end
