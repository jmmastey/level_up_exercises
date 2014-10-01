require_relative "load_json_stats"

describe LoadJsonStats do
  describe "#get_data_stats" do
    let(:test_file) { "test_data.json" }
    subject(:get_data) { LoadJsonStats.get_data_stats(test_file) }

    it "should return two data stats" do
      expect(get_data.length).to eq 2
    end

    it "should have cohort A" do
      expect(get_data).to include(DataStats.new("A", 2, 1))
    end

    it "should have cohort B" do
      expect(get_data).to include(DataStats.new("B", 3, 2))
    end
  end
end
