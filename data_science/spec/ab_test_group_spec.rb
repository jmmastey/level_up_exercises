require_relative "../ab_test_group.rb"

describe ABTest::ABTestGroup do

  let(:abg) { ABTest::ABTestGroup.new(converts: 443, nonconverts: 5325) }

  it "accepts conversion data in constructor" do
    expect(abg.converts).to be == 443
  end

  it "accepts non-conversion data in constructor" do
    expect(abg.nonconverts).to be == 5325
  end

  it "accepts conversion data via #add_converts" do
    abg.add_converts(10)
    expect(abg.converts).to be == 453
  end

  it "accepts non-conversion data via #add_nonconverts" do
    abg.add_nonconverts(10)
    expect(abg.nonconverts).to be == 5335
  end

  it "computes total visitors" do
    expect(abg.visitors).to be == 5768
  end

  it "computes conversion ratio" do
    expect(abg.conversion_ratio).to be_within(0.0001).of(0.0768)
  end

  it "computes standard error" do
    expect(abg.standard_error).to be_within(0.00001).of(0.00351)
  end

  it "computes error margin at 95th percentile confidence" do
    expect(abg.error_margin).to be_within(0.00001).of(0.00688)
  end

  it "computes correct 95% confidence interval" do
    lo = abg.conversion_ratio - abg.error_margin
    hi = abg.conversion_ratio + abg.error_margin
    expect(abg.confidence_interval_95).to be == (lo..hi)
  end
end
