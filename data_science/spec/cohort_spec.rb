require_relative '../cohort.rb'

describe Cohort do
  let(:cohort) {Cohort.new("A")}

  it "has a name" do
    expect(cohort.name).to eq("A")
  end

  describe '#total_views' do
    let(:cohort) {Cohort.new("A")}

    it "total number of views in the cohort"  do
      expect(cohort.total_views).to eq(3)
    end
  end
end
