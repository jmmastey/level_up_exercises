require_relative "../data_analyzer"
require_relative "spec_helpers"

describe DataAnalyzer do
  let(:loader) { DataLoader.new(data: generate_data) }

  subject(:analyzer) { DataAnalyzer.new(loader) }

  context "when an instance is created" do
    it "is a valid instance" do
      is_expected.to be_instance_of(DataAnalyzer)
    end
  end

  context "when data is loaded" do
    before(:each) do
      analyzer.load(agroup: { cohort: "A" }, bgroup: { cohort: "B" })
    end

    it "contains two distinct groups" do
      expect(analyzer.groups.size).to eq(2)
    end

    describe "#sample_size" do
      it "reports the total sample size if no group is specified" do
        expect(analyzer.sample_size).to eq(195)
      end

      it "reports the sample size for agroup" do
        expect(analyzer.sample_size(:agroup)).to eq(87)
      end

      it "reports the sample size for bgroup" do
        expect(analyzer.sample_size(:bgroup)).to eq(108)
      end
    end

    describe "#conversion_count" do
      it "reports the conversion count for agroup" do
        expect(analyzer.conversion_count(:agroup)).to eq(5)
      end

      it "reports the conversion count for bgroup" do
        expect(analyzer.conversion_count(:bgroup)).to eq(9)
      end

      it "reports the conversion rate for bgroup" do
        expect(analyzer.conversion_rate(:bgroup).round(3)).to \
          be_within(0.005).of(0.085)
      end
    end

    context "when reporting the 95% confidence interval" do
      let(:interval) { analyzer.confidence_interval(:bgroup, 0.95) }
      let(:upper_bound) { interval[:high] }
      let(:lower_bound) { interval[:low] }

      it "provides an upper boundary" do
        expect(upper_bound.round(3)).to be_within(0.002).of(0.135)
      end

      it "provides a lower boundary" do
        expect(lower_bound.round(3)).to be_within(0.002).of(0.030)
      end
    end

    context "when analyzing data" do
      it "calculates a p-value" do
        expect(analyzer.p_value).to be_kind_of(Float)
      end

      it "tests for statistical significance" do
        expect(analyzer.significant?).to be false
      end
    end
  end
end
