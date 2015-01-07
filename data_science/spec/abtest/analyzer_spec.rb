require "abtest/sample"
require "abtest/sample_loader"
require "abtest/analyzer"

module ABTest
  describe Analyzer do
    let(:test_data) do
      test_file = File.new(File.expand_path("../analyzer_test.json", __FILE__))
      SampleLoader.load(test_file)
    end

    describe "#sample_size" do
      it "returns total sample size" do
        analyzer = Analyzer.new(test_data)
        expect(analyzer.sample_size).to eq(20)
      end
    end

    describe "#conversions_by_cohort" do
      it "returns the number of conversions for each cohort" do
        analyzer = Analyzer.new(test_data)
        expect(analyzer.conversions_by_cohort).to eq("A" => 3, "B" => 6)
      end
    end

    describe "#conversion_percentage_by_cohort" do
      it "returns the percentage of conversions for each cohort" do
        analyzer = Analyzer.new(test_data)
        expect(analyzer.conversion_percentage_by_cohort).to \
          eq("A" => 30, "B" => 60)
      end
    end

    describe "#standard_error_by_cohort" do
      it "returns the standard error for each cohort" do
        analyzer = Analyzer.new(test_data)
        expect(analyzer.standard_error_by_cohort).to \
          eq("A" => 0.14491, "B" => 0.15492)
      end
    end

    describe "#confidence_interval_by_cohort" do
      it "returns the 95% confidence interval for each cohort" do
        analyzer = Analyzer.new(test_data)
        expect(analyzer.confidence_interval_by_cohort).to \
          eq("A" => [1.6, 58.4], "B" => [29.64, 90.36])
      end
    end

    describe "#chi_squared" do
      it "returns chi-squared" do
        analyzer = Analyzer.new(test_data)
        expect(analyzer.chi_squared).to eq(1.82)
      end
    end

    describe "#significant?" do
      it "returns false when difference is not significant" do
        analyzer = Analyzer.new(test_data)
        expect(analyzer.significant?).to be false
      end
    end
  end
end
