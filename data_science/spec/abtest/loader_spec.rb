require "abtest/sample"
require "abtest/sample_loader"

module ABTest
  describe SampleLoader do
    let(:test_file) do
      File.new(File.expand_path("../loader_test.json", __FILE__))
    end
    let(:bad_test_file) do
      File.new(File.expand_path("../loader_test.xml", __FILE__))
    end
    let(:test_string) { '[{"date":"2015-01-05", "cohort":"X", "result":1}]' }

    describe "::load" do
      it "returns an array of samples when given a JSON string" do
        expect(SampleLoader.load(test_string)).to \
          match_array([Sample.new("2015-01-05", "X", 1)])
      end
      it "returns an array of samples when given a file containing JSON" do
        expect(SampleLoader.load(test_file)).to match_array([
          Sample.new("2015-01-05", "A", 0),
          Sample.new("2015-01-05", "B", 1)])
      end
      it "raises an exception when given a file that does not contain JSON" do
        expect { SampleLoader.load(bad_test_file) }.to raise_error
      end
    end
  end
end
