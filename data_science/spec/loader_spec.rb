require_relative '../loader.rb'
require_relative '../spec_helper.rb'

describe Loader do
  # The alternative would have been a string version of json file
  let(:data) do
    { data:
      [{ date: "2014-03-20", cohort: "B", result: 0 },
       { date: "2014-05-19", cohort: "B", result: 0 }]
      }.to_json
  end

  let(:experiment_file) { "./test.json" }
  let(:experiment_data) { Loader.new(file_contents: experiment_file) }

  before do
    # making a fake "read" method on the File class, that returns the fake data
    allow(File).to receive(:read).with("filename").and_return(data)
    allow(File).to receive(:read).with("").and_raise(Errno::ENOENT)
  end

  describe "#initialize" do
    context "if there is no file" do
      it "raises an error" do
        expect{ Loader.new("") }.to raise_error(Errno::ENOENT)
      end
    end

    context "if there is a file" do
      it "sets file contents to the contents of the file" do
      expect(Loader.new("filename").file_contents).to eq(data)
      end

      it "runs the parse method" do
        #foo = Loader.new("filename")
        #expect(@foo).to receive(:parse)
      end
    end
  end

  describe "#parse" do
    it "creates cohort group for each letter" do

    end

    it "counts all cohort samples that are 'A' to cohort A" do
      expect(cohort.size).to be 300
    end

    it "counts all cohort 'A' sample that are positive" do

    end 
  end

  describe '#calculate' do
    it "calculates standard deviation" do
    end
  end

  describe '#report' do
    it "prints the conversion rate" do

    end

    it "prints the " do

    end
  end
end
