require "rspec"

require_relative "../viewparser"
require_relative "../dataset.rb"

describe DataSet do
  context "upon recieving data" do
    let (:raw_data) do
      %q([{"date":"2014-03-15","cohort":"B","result":1},
          {"date":"2014-03-20","cohort":"B","result":0},
          {"date":"2014-03-20","cohort":"B","result":0},
          {"date":"2014-03-17","cohort":"B","result":0},
          {"date":"2014-03-21","cohort":"A","result":1},
          {"date":"2014-03-20","cohort":"A","result":0}])
    end

    let (:data) do
      ViewParser.new.parse(raw_data)
    end

    let(:data_set) do
      DataSet.new(grouping_field: :id, control_id: "A",
         result_field: :purchased, data: data)
    end

    it "should provide the total chance success value" do
      expect(data_set.percentage_success).to eq(2.0 / 6)
    end

    it "should provide the chance success by group" do
      expect(data_set.percentage_success_by_group("A")).to eq(0.5)
      expect(data_set.percentage_success_by_group("B")).to eq(0.25)
    end

    it "should provide the total chance fail value" do
      expect(data_set.percentage_fail).to eq(1 - (2.0 / 6))
    end

    it "should provide the chance fail by group" do
      expect(data_set.percentage_fail_by_group("A")).to eq(0.5)
      expect(data_set.percentage_fail_by_group("B")).to eq(0.75)
    end
  end
end
