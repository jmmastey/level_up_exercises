require_relative "../output_formatter"

describe OutputFormatter do
  it "can be initialized with no parameters" do
    OutputFormatter.new
  end

  let(:formatter) { OutputFormatter.new }

  describe "#format" do
    it "formats SplitTestGroups" do
      group = SplitTestGroup.new(name: "A",
                                 views: 1000,
                                 conversions: 50)

      formatted_text = formatter.format(group)

      expect(formatted_text).to include("Group A")
      expect(formatted_text).to include("50 conversions")
      expect(formatted_text).to include("1000 views")
      expect(formatted_text).to include("5.00% \xc2\xb1 1.35% conversion rate")
    end

    it "formats SplitTestCalculators" do
      control = SplitTestGroup.new(name: "A", views: 1349, conversions: 47)
      variation = SplitTestGroup.new(name: "B", views: 1543, conversions: 79)
      calc = SplitTestCalculator.new(control_group: control,
                                     variation_group: variation)

      formatted_text = formatter.format(calc)

      expect(formatted_text).to include(formatter.format(control))
      expect(formatted_text).to include(formatter.format(variation))
      expect(formatted_text).to include("confident")
      expect(formatted_text).to include("The variation group is superior.")
    end
  end
end
