require_relative '../cohort.rb'

describe Cohort do
  let(:cohort) {Cohort.new("A")}

  it "has a name" do
    expect(cohort.name).to eq("A")
  end

  it "counts"
end
