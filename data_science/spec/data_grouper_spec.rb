require_relative "../data_grouper"
require_relative "../split_test_group"

describe DataGrouper do
  let(:grouper) { DataGrouper.new }
  let(:entries) do
    [
      DataEntry.new(cohort: "A", date: "2014-04-03", result: 0),
      DataEntry.new(cohort: "A", date: "2014-04-03", result: 1),
      DataEntry.new(cohort: "A", date: "2014-04-03", result: 0),
      DataEntry.new(cohort: "A", date: "2014-04-03", result: 1),
      DataEntry.new(cohort: "A", date: "2014-04-03", result: 0),
      DataEntry.new(cohort: "B", date: "2014-04-03", result: 0),
      DataEntry.new(cohort: "B", date: "2014-04-03", result: 1),
      DataEntry.new(cohort: "B", date: "2014-04-03", result: 1),
      DataEntry.new(cohort: "A", date: "2014-04-03", result: 1),
      DataEntry.new(cohort: "A", date: "2014-04-03", result: 0),
      DataEntry.new(cohort: "B", date: "2014-04-03", result: 0)
    ]
  end
  let(:groups) { grouper.create_groups(entries) }
  let(:group_a) { groups.select { |group| group.name == "A" }.first }
  let(:group_b) { groups.select { |group| group.name == "B" }.first }

  it "initializes without parameters" do
    expect { grouper }.not_to raise_error
  end

  describe "#create_groups" do
    it "converts data entries into a collection of groups" do
      groups.each do |group|
        expect(group).to be_a(SplitTestGroup)
      end
    end

    it "groups by cohort" do
      expect(group_a.name).to eq("A")
      expect(group_b.name).to eq("B")
    end
  end
end
