require 'spec_helper'
require 'data_set'

describe DataSet do
  let(:data_points) do
    [
      { cohort: "C", result: 0 },
      { cohort: "B", result: 0 },
      { cohort: "B", result: 1 },
      { cohort: "B", result: 1 },
    ]
  end
  let(:data_set) { DataSet.new(data_points: data_points) }

  describe "#cohorts" do
    it "lists the cohorts" do
      expect(data_set.cohorts).to match_array(%w(B C))
    end
  end

  describe "#views" do
    context "when the named cohort has duplicate data points" do
      it "counts every data point" do
        expect(data_set.views("B")).to eq(3)
      end
    end

    context "when the named cohort has views but no conversions" do
      it "counts every data point" do
        expect(data_set.views("C")).to eq(1)
      end
    end

    context "when the named cohort does not have data" do
      it "reports 0 views" do
        expect(data_set.views("A")).to eq(0)
      end
    end
  end

  describe "#conversions" do
    context "when the named cohort has duplicate data points" do
      it "counts every data point that converted" do
        expect(data_set.conversions("B")).to eq(2)
      end
    end

    context "when the named cohort has views but no conversions" do
      it "reports 0 conversions" do
        expect(data_set.conversions("C")).to eq(0)
      end
    end

    context "when the named cohort does not have data" do
      it "reports 0 conversions" do
        expect(data_set.conversions("A")).to eq(0)
      end
    end
  end

  context "when reading a malformed file" do
    let(:data_file) { "spec/spec_data/malformed.json" }
    it "raises an error" do
      expect { DataSet.new(file_name: data_file) }.to raise_error(BadDataFile)
    end
  end

  context "when reading a valid json file" do
    let(:data_file) { "spec/spec_data/list_of_two_hashes.json" }
    it "correctly populates data" do
      data_set = DataSet.new(file_name: data_file)
      expect(data_set.views("B")).to eql(2)
      expect(data_set.conversions("B")).to eql(2)
    end
  end

  context "when reading an empty file" do
    let(:data_file) { "spec/spec_data/empty.json" }
    it "has no data" do
      data_set = DataSet.new(file_name: data_file)
      expect(data_set.data).to be_empty
    end
  end
end
