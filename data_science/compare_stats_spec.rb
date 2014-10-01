require_relative "compare_stats"
require_relative "data_stats"

describe CompareStats do
  context "Clear winner defined" do
    let(:data_stats_a) { DataStats.new("A", 100, 30) }
    let(:data_stats_b) { DataStats.new("B", 100, 50) }
    let(:compare_stats) { CompareStats.new(data_stats_a, data_stats_b) }

    describe "#leader" do
      subject { compare_stats.leader }
      it { is_expected.to eq(data_stats_b) }
    end

    describe "#probabilty_level" do
      subject { compare_stats.probabilty_level }
      it { is_expected.to be_within(0.0001).of(0.00389) }
    end

    describe "#significant_difference?" do
      subject { compare_stats.significant_difference? }
      it { is_expected.to be true }
    end
  end

  context "No clear winner" do
    let(:data_stats_a) { DataStats.new("A", 100, 30) }
    let(:data_stats_b) { DataStats.new("B", 100, 31) }
    let(:compare_stats) { CompareStats.new(data_stats_a, data_stats_b) }

    describe "#leader" do
      subject { compare_stats.leader }
      it { is_expected.to eq(data_stats_b) }
    end

    describe "#probabilty_level" do
      subject { compare_stats.probabilty_level }
      it { is_expected.to be_within(0.01).of(0.88) }
    end

    describe "#significant_difference?" do
      subject { compare_stats.significant_difference? }
      it { is_expected.to be false }
    end
  end
end
