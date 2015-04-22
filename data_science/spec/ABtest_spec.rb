require_relative '../ABtest'

require 'json'

describe ABtest do

  before :all do
    file = File.read('abbreviated_data.json')
    all_data = JSON.parse(file)
    pop_A = all_data.select { |record| record["cohort"] == "A" }
    pop_B = all_data.select { |record| record["cohort"] == "B" }
    cohort_A = Cohort.new(pop_A)
    cohort_B = Cohort.new(pop_B)
    @ABtest = ABtest.new(cohort_A, cohort_B)
  end

  describe("#new") do 
    it "takes 2 cohorts and returns and ABtest object" do
      expect(@ABtest).to(be_an_instance_of(ABtest))
    end
  end
 
  describe("@new") do
    it "has 2 instance variables, cohort_A, cohort_B of type Cohort" do 
      expect(@ABtest.cohort_A).to(be_an_instance_of(Cohort))
      expect(@ABtest.cohort_B).to(be_an_instance_of(Cohort))
    end
  end

  it "finds the leader in conversion rates" do
    expect(@ABtest.leader).to(eql(@ABtest.cohort_B.name))
  end

  it "determines if there is a signifcant leader" do
    expect(@ABtest.compute_leader_confidence_level).to(eql(0.9817441394125406))
  end

  
 
end
