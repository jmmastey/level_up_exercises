require_relative "data_stats"

describe DataStats do
  context "no data loaded" do
    let(:data_stats) { DataStats.new }

    describe "#conversion_percent" do
      it "raises zero divison error" do
        expect { data_stats.conversion_percent }
          .to raise_error(ZeroDivisionError)
      end
    end

    describe "#conversion_confidence" do
      it "raises zero divison error" do
        expect { data_stats.conversion_confidence }
          .to raise_error(ZeroDivisionError)
      end
    end
  end

  context "sample data loaded" do
    let(:data_stats) { DataStats.new("Test", 100, 30) }
    let(:percent_conversions) { 0.30 }
    let(:error) { Math.sqrt(0.0021) * 1.96 }

    describe "#conversion_percent" do
      subject { data_stats.conversion_percent }
      it { is_expected.to eq 0.30 }
    end

    describe "#conversion_confidence" do
      subject { data_stats.conversion_confidence }
      it { is_expected.to be_within(0.00001).of(0.0898184) }
    end
  end
end
