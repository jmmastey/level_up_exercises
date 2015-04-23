require_relative '../ABtest'

require 'json'

describe ABtest do
  before :all do
    file = File.read('abbreviated_data.json')
    all_data = JSON.parse(file)
    pop_a = all_data.select { |record| record["cohort"] == "A" }
    pop_b = all_data.select { |record| record["cohort"] == "B" }
    cohort_a = Cohort.new(pop_a)
    cohort_b = Cohort.new(pop_b)
    @ab_test = ABtest.new(cohort_a, cohort_b)
  end

  describe("#new") do
    it "takes 2 cohorts and returns and ABtest object" do
      expect(@ABtest).to(be_an_instance_of(ABtest))
    end
  end
  describe("@new") do
    it "has 2 instance variables, cohort_A, cohort_B of type Cohort" do
      expect(@ab_test.cohort_a).to(be_an_instance_of(Cohort))
      expect(@ab_test.cohort_b).to(be_an_instance_of(Cohort))
    end
  end

  it "finds the leader in conversion rates" do
    expect(@ab_test.leader).to(eql(@ab_test.cohort_B.name))
  end

  it "determines if there is a signifcant leader" do
    expect(@ab_test.compute_leader_confidence_level).to(eql(0.9817441394125406))
  end
end
