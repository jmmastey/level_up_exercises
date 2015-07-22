require 'spec_helper'
require 'data_set'

describe DataSet do
  let(:data_set) { DataSetFactory.create }

  it "reports its count of data points" do
    expect(data_set.count(:all)).to be(3)
  end

  it "reports its count of data points that match 1 requirement" do
    expect(data_set.count(result: 0)).to be(2)
  end

  it "reports its count of data points that match 2 requirements" do
    expect(data_set.count(result: 0, cohort: "B")).to be(1)
  end

  it "returns .possible_values for a measure" do
    expect(data_set.possible_values(:cohort)).to contain_exactly("A", "B")
  end
end

module DataSetFactory
  def self.create
    data = [
      DataPoint.new(date: "2014-03-21", cohort: "B", result: 0),
      DataPoint.new(date: "2014-03-22", cohort: "B", result: 1),
      DataPoint.new(date: "2014-03-23", cohort: "A", result: 0),
    ]
    DataSet.new(data: data)
  end
end
