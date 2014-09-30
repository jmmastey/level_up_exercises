require "rspec"

require_relative "../view_parser"
require_relative "../binomial_data_set.rb"

describe BinomialDataGroup do
  context "upon recieving data" do
    let(:raw_data) do
      %q([{"date":"2014-03-15","cohort":"B","result":1},
          {"date":"2014-03-20","cohort":"B","result":0},
          {"date":"2014-03-20","cohort":"B","result":0},
          {"date":"2014-03-17","cohort":"B","result":0}])
    end

    let(:data) do
      ViewParser.new.parse(raw_data)
    end

    let(:data_group) do
      BinomialDataGroup.new(id: "B", result_field: :purchased,
        data: data)
    end

    it "provides the success count" do
      expect(data_group.success_count).to eq(1)
    end

    it "shoud provide the fail count" do
      expect(data_group.fail_count).to eq(3)
    end

    it "provides the total count" do
      expect(data_group.count).to eq(4)
    end

    it "provides the success percent" do
      expect(data_group.success_percent).to eq(0.25)
    end

    it "provides the fail percent" do
      expect(data_group.fail_percent).to eq(0.75)
    end
  end
end
