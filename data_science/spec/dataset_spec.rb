require "rspec"

require_relative "../viewparser"
require_relative "../dataset.rb"

describe DataSet do
  context "upon recieving data" do
    let(:raw_data) do
      %q([{"date":"2014-03-15","cohort":"B","result":1},
          {"date":"2014-03-20","cohort":"B","result":0},
          {"date":"2014-03-20","cohort":"B","result":0},
          {"date":"2014-03-17","cohort":"B","result":0},
          {"date":"2014-03-21","cohort":"A","result":1},
          {"date":"2014-03-20","cohort":"A","result":0}])
    end

    let(:data) do
      ViewParser.new.parse(raw_data)
    end

    let(:data_set) do
      DataSet.new(group_field: :id, control_id: "A",
         result_field: :purchased, data: data)
    end

    let(:groups) do
      data_set.groups
    end

    it "should provide the total chance success value" do
      expect(data_set.success_percent).to eq(2.0 / 6)
    end

    it "should provide the total success count" do
      expect(data_set.success_count).to eq(2)
    end

    it "should provide the chance success by group" do
      expect(data_set.success_percent(group: "A")).to eq(0.5)
      expect(data_set.success_percent(group: "B")).to eq(0.25)
    end

    it "should provide the success count by group" do
      expect(data_set.success_count(group: "A")).to eq(1)
      expect(data_set.success_count(group: "B")).to eq(1)
    end

    it "should provide the total chance fail value" do
      expect(data_set.fail_percent).to eq(4.0 / 6)
    end

    it "should provide the total fail count" do
      expect(data_set.fail_count).to eq(4)
    end

    it "should provide the chance fail by group" do
      expect(data_set.fail_percent(group: "A")).to eq(0.5)
      expect(data_set.fail_percent(group: "B")).to eq(0.75)
    end

    it "should provide the fail count by group" do
      expect(data_set.fail_count(group: "A")).to eq(1)
      expect(data_set.fail_count(group: "B")).to eq(3)
    end

    it "should group things by the group field" do
      expect(groups["A"].size).to eq(2)
      expect(groups["B"].size).to eq(4)
    end
  end
end
