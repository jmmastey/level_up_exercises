require "abtest/cohort"
require "abtest/sample_loader"

module ABTest
  describe Cohort do
    let(:samples) do
      samples_file = File.new(File.expand_path("../cohort_test.json", __FILE__))
      SampleLoader.load(samples_file)
    end
    let(:cohort) { Cohort.new(samples) }

    describe "#name" do
      it "returns the name of the cohort" do
        expect(cohort.name).to eq("A")
      end
    end

    describe "#conversions" do
      it "returns the number of conversions" do
        expect(cohort.conversions).to eq(5)
      end
    end

    describe "#conversion_rate" do
      it "returns the conversion rate" do
        expect(cohort.conversion_rate).to eq(0.5)
      end
    end

    describe "#sample_size" do
      it "returns the number of samples" do
        expect(cohort.sample_size).to eq(10)
      end
    end

    describe "#conversion_percentage" do
      it "returns the conversion percentage" do
        expect(cohort.conversion_percentage).to eq(50)
      end
    end

    describe "#standard_error" do
      it "returns the standard error" do
        expect(cohort.standard_error).to eq(0.15811)
      end
    end

    describe "#confidence_interval" do
      it "returns the confidence interval" do
        expect(cohort.confidence_interval).to eq([19.01, 80.99])
      end
    end

    describe "#failures" do
      it "returns the number of failures" do
        expect(cohort.failures).to eq(5)
      end
    end
  end
end
