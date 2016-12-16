require './data_from_file'

describe DataFromFile do
  describe ".get" do
    let(:file_path) { "filepath" }
    let(:file_data) do
      [{ "date" => "2014-03-20", "cohort" => "B", "result" => 0 },
       { "date" => "2014-03-20", "cohort" => "A", "result" => 1 }]
    end
    let(:json_data) { file_data.to_json }
    let(:loaded_data) { DataFromFile.get(file_path) }

    before(:each) do
      allow(File).to receive(:read).and_return(json_data)
    end

    it "returns an array of hashes" do
      expect(loaded_data).to be_an(Array)
    end

    it "includes hashes from the loaded file" do
      expect(loaded_data).to include(file_data.first)
      expect(loaded_data).to include(file_data.last)
    end
  end
end
