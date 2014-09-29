require_relative '../lib/loader'

describe "Loader" do
  describe "#initialize" do
    it "raises an error if the file does not exist" do	
      expect{ Loader.new("abcde") }.to raise_exception(Errno::ENOENT)
    end
    
    it "returns data after parsing file" do	
      expect(Loader.new("lib/source_data.json").parse_json).to_not be_nil
    end
  end
end
