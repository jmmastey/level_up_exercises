require_relative "../data_loader"

describe DataLoader do
  let(:filepath) { File.expand_path("../data/sample_data.json", __FILE__) }
  let(:loader)   { DataLoader.new(filepath) }

  context "#initialize" do
    it "produces a valid instance" do
      expect(loader).to be_instance_of(DataLoader)
    end

    it "creates a valid data array" do
      expect(loader.data).to be_kind_of(Array)
    end

    it "loads more than 0 records" do
      expect(loader.data.size).to be > 0
    end

    it "raises an exception if file doesn't exist" do
      expect { DataLoader.new("i_dont_exist.json") }.to \
        raise_error(SystemCallError)
    end

    it "raises an exception if source is not JSON" do
      expect { DataLoader.new(__FILE__) }.to raise_error(JSON::ParserError)
    end
  end

  context "#fetch" do
    let(:filtered_loader) { loader.fetch(cohort: "A") }

    it "returns an array" do
      expect(filtered_loader).to be_kind_of(Array)
    end

    it "returns more than 0 records" do
      expect(filtered_loader.size).to be > 0
    end

    it "does not contain rejected items" do
      b_size = filtered_loader.count { |i| i[:cohort] == "B" }
      expect(b_size).to eq(0)
    end

    it "does contain selected items" do
      a_size = filtered_loader.count { |i| i[:cohort] == "A" }
      expect(a_size).to eq(filtered_loader.size)
    end
  end
end
