require 'spec_helper'
require 'data_reader'

describe DataReader do
  context "reading a valid json file" do
    let(:data_reader) { ReaderFactory.create("list_of_two_hashes") }
    let(:data) { [DataPointFactory.create, DataPointFactory.create(day: "21")] }
    it "returns the DataPoints" do
      expect(data_reader.data).to eql(data)
    end
  end

  context "reading an empty file" do
    let(:data_reader) { ReaderFactory.create("empty") }
    it "stores an empty list" do
      expect(data_reader.data).to eq([])
    end
  end

  context "reading a malformed file" do
    it "raises an error" do
      expect { ReaderFactory.create("malformed") }.to raise_error(BadDataFile)
    end
  end
end

module ReaderFactory
  def self.create(name)
    DataReader.new("spec/spec_data/#{name}.json")
  end
end

module DataPointFactory
  def self.create(day: "20")
    DataPoint.new(date: "2014-03-#{day}", cohort: "B", result: 1)
  end
end
