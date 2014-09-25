require_relative "../output_formatter"

describe OutputFormatter do
  let(:test_group) do
    SplitTestGroup.new(name: "A",
                       views: 1000,
                       conversions: 50)
  end

  let(:control_group) do
    SplitTestGroup.new(name: "A", views: 1349, conversions: 47)
  end

  let(:variation_group) do
    SplitTestGroup.new(name: "B", views: 1543, conversions: 79)
  end

  let(:calc) { SplitTestCalculator.new(control_group, variation_group) }

  let(:formatter) { OutputFormatter.new }

  it "can be initialized with no parameters" do
    expect { formatter }.not_to raise_error
  end

  describe "#format" do
    it "formats SplitTestGroups" do

      formatted_text = formatter.format(test_group)

      expect(formatted_text).to include("Group A")
      expect(formatted_text).to include("50 conversions")
      expect(formatted_text).to include("1000 views")
      expect(formatted_text).to include("5.00% \xc2\xb1 1.35% conversion rate")
    end

    it "formats SplitTestCalculators" do
      formatted_text = formatter.format(calc)

      expect(formatted_text).to include(formatter.format(control_group))
      expect(formatted_text).to include(formatter.format(variation_group))
      expect(formatted_text).to include("Confidence in variation: 96")
      expect(formatted_text).to include("Group 'B' is superior.")
    end
  end
end
