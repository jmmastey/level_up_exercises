require "spec_helper"
require "./confidence"

# Float Comparison
def equals(x, y)
  (x.to_f - y.to_f).abs < 1e-8
end


describe Confidence do
  let(:confidence) { Confidence.new }
  let(:interval_a) { confidence.interval("A") }
  let(:interval_b) { confidence.interval("B") }
  let(:an_angstrom) { 1e-10 }

  before(:each) do
    4.times { confidence.add(Observation.new("A", true )) }
    4.times { confidence.add(Observation.new("A", false)) }
    9.times { confidence.add(Observation.new("B", true )) }
    7.times { confidence.add(Observation.new("B", false)) }
  end

  it "should contain list of subjects" do
    expect(confidence.subjects.count).to eq(2)
    expect(confidence.subjects[0]).to eq("A")
    expect(confidence.subjects[1]).to eq("B")
  end

  it "should compute the confidence interval for A correctly" do
    expect(interval_a.lower).to be_within(an_angstrom).of(0.5 - 0.3535533906)
    expect(interval_a.upper).to be_within(an_angstrom).of(0.5 + 0.3535533906)
    expect(interval_a.midpt).to be_within(an_angstrom).of(0.5)
  end

  it "should compute the confidence interval for B correctly" do
    expect(interval_b.lower).to be_within(an_angstrom).of(0.5625 - 0.2480391854)
    expect(interval_b.upper).to be_within(an_angstrom).of(0.5625 + 0.2480391854)
    expect(interval_b.midpt).to be_within(an_angstrom).of(0.5625)
  end  

  it "should compute the max-cohort correctly" do
    expect(confidence.get_max_subject).to eq("B")
    expect(confidence.get_max_conversion).to be_within(an_angstrom).of(0.5625)
    expect(confidence).not_to have_distinct_means
  end
end
