require_relative '../cohort'

describe Cohort do
  it "has a name" do
    expect{Cohort.new}.to raise_error(ArgumentError, "wrong number of arguments (0 for 1)") 
  end

  it "has stats positive, negative and total" do
    cohort = Cohort.new("name")

    expect(cohort.stats).to eq({positive: 0, total: 0, negative: 0})
  end

  it "is equal to another object with the same name" do
    cohort_B = Cohort.new("B")
    cohort_or_not_to_B = Cohort.new("B")
    
    expect(cohort_B.eql? cohort_or_not_to_B).to be(true)
    expect(cohort_B == cohort_or_not_to_B).to be(true)
  end
  
end
