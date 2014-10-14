require_relative "../split_test_group"

describe SplitTestGroup do

  let(:group_a) do
    SplitTestGroup.new(name: "A",
                       num_views: 1349,
                       num_conversions: 47)
  end

  let(:group_b) do
    SplitTestGroup.new(name: "B",
                       num_views: 1543,
                       num_conversions: 79)
  end

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

  describe "#conversion_rate_error" do
    it "gets the conversion rate confidence error" do
      rounded_error = group_a.conversion_rate_error.round(4)
      expect(rounded_error).to eq(0.0098)
    end
  end

  describe "#conversion_rate_range" do
    it "gets the 95% confident range of the conversion rate" do
      min, max = group_a.conversion_rate_range

      expect(min).to eq(group_a.conversion_rate - group_a.conversion_rate_error)
      expect(max).to eq(group_a.conversion_rate + group_a.conversion_rate_error)
    end
  end

  describe "#to_s" do
    subject(:formatted_text) { group_a.to_s }

    it "should contain the name of the group" do
      expect(formatted_text).to include("Group A")
    end

    it "should contain the number of conversions" do
      expect(formatted_text).to include("47 conversions")
    end

    it "should contain the number of views" do
      expect(formatted_text).to include("1349 views")
    end

    it "should include the conversion rate" do
      expect(formatted_text).to include("3.48%")
    end

    it "should include the conversion rate error" do
      expect(formatted_text).to include("\xc2\xb1 0.98%")
    end
  end
end
