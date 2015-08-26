require "date"
require_relative "../data_loader"
require_relative "spec_helpers"

describe DataLoader do
  let(:filepath) { File.expand_path("../data/sample_data.json", __FILE__) }
  let(:loader) { DataLoader.new(file: filepath) }
  let(:procedural_loader) { DataLoader.new(data: generate_data) }

  describe "#initialize" do
    it "produces a valid instance" do
      expect(loader).to be_instance_of(DataLoader)
      expect(procedural_loader).to be_instance_of(DataLoader)
    end

    it "creates a valid data array" do
      expect(loader.data).to be_kind_of(Array)
      expect(procedural_loader.data).to be_kind_of(Array)
    end

    it "loads more than 0 records" do
      expect(loader.data).not_to be_empty
      expect(procedural_loader.data).not_to be_empty
    end

    context "with a data file" do
      it "raises an exception if file doesn't exist" do
        expect { DataLoader.new(file: "i_dont_exist.json") }.to \
          raise_error(SystemCallError)
      end

      it "raises an exception if source file is not JSON" do
        expect { DataLoader.new(file: __FILE__) }.to \
          raise_error(JSON::ParserError)
      end
    end

    it "raises an error if no data is provided" do
      expect { DataLoader.new }.to raise_error(ArgumentError)
    end

    context "with direct data" do
      it "raises an error if empty data is provided" do
        expect { DataLoader.new(data: []) }.to raise_error(ArgumentError)
      end

      it "raises an error if malformed data is provided" do
        expect { DataLoader.new(data: [1, 2, "C"]) }.to \
          raise_error(ArgumentError)
      end

      it "does not raise an exception if valid data is provided" do
        expect { DataLoader.new(data: [{ cohort: "A" }]) }.not_to raise_error
      end
    end
  end

  describe "#fetch" do
    let(:filtered_loader) { loader.fetch(cohort: "A") }
    let(:a_size) { filtered_loader.count { |i| i[:cohort] == "A" } }
    let(:b_size) { filtered_loader.count { |i| i[:cohort] == "B" } }

    it "returns an array" do
      expect(filtered_loader).to be_kind_of(Array)
    end

    it "returns more than 0 records" do
      expect(filtered_loader.size).to be > 0
    end

    it "does not contain rejected items" do
      expect(b_size).to eq(0)
    end

    it "does contain selected items" do
      expect(a_size).to eq(filtered_loader.size)
    end
  end
end
