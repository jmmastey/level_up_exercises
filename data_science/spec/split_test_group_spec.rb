require_relative "../split_test_group"

describe SplitTestGroup do

  let(:group_a) { SplitTestGroup.new(name: "A", views: 1349, conversions: 47) }
  let(:group_b) { SplitTestGroup.new(name: "B", views: 1543, conversions: 79) }

  it "can be initialized with the numbers of views and conversions" do
    expect(group_a.name).to eq("A")
    expect(group_a.views).to eq(1349)
    expect(group_a.conversions).to eq(47)

    expect(group_b.name).to eq("B")
    expect(group_b.views).to eq(1543)
    expect(group_b.conversions).to eq(79)
  end

  describe "#conversion_rate" do
    it "gets the average conversion rate" do
      rounded_conversion_rate = group_a.conversion_rate.round(4)
      expect(rounded_conversion_rate).to eq(0.0348)
      rounded_conversion_rate = group_b.conversion_rate.round(4)
      expect(rounded_conversion_rate).to eq(0.0512)
    end
  end

  describe "#conversion_rate_interval" do
    it "gets the conversion rate confidence interval" do
      rounded_interval = group_a.conversion_rate_interval.round(4)
      expect(rounded_interval).to eq(0.0098)
    end
  end

  describe "#conversion_rate_range" do
    it "gets the 95% confident range of the conversion rate" do
      min, max = group_a.conversion_rate_range

      expect(min).to eq(group_a.conversion_rate - group_a.conversion_rate_interval)
      expect(max).to eq(group_a.conversion_rate + group_a.conversion_rate_interval)
    end
  end
end
