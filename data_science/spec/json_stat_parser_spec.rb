require_relative '../json_stat_parser'

describe JSONStatParser do
  describe "#read" do
    before(:all) do
      @parser = JSONStatParser.new
      @file_path = "source_data.json"
    end

    it "returns an Enumerable of statistics from a JSON file" do
      data = @parser.read(@file_path)

      expect(data).to be_an(Enumerable)
    end

    it "contains data entries" do
      data = @parser.read(@file_path)

      data.all? do |entry|
        expect(entry).to be_a(DataEntry)
      end
    end
  end
end
