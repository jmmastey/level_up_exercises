require 'spec_helper'

describe ABSplitTest do
  let(:tallied_data) do
    instance_double("ABDataSummary", a_conv: 100, a_nonconv: 51,
      b_conv: 52, b_nonconv: 53,
      to_h: {
        a: { conv: 100, nonconv: 51 },
        b: { conv: 52, nonconv: 53 },
      }
    )
  end
  subject(:sample_test) { ABSplitTest.new(tallied_data) }
  describe "#confidence_level" do
    it "returns correct confidence level" do
      expect(sample_test.confidence_level).to eq(0.992553)
    end
  end

  describe "#to_s" do
    it "prints stats for each cohort" do
      expect(sample_test.to_s).to include(
        sample_test.a_cohort.to_s,
        sample_test.b_cohort.to_s,
        )
    end
  end

  describe "#test_winner" do
    context "when A is winner" do
      it "returns that A is winner" do
        expect(sample_test.test_winner).to eq("A")
      end
    end

    context "when there is no winner" do
      let(:data_with_no_winner) do
        instance_double("ABDataSummary", a_conv: 50, a_nonconv: 51,
          b_conv: 52, b_nonconv: 53,
          to_h: {
            a: { conv: 50, nonconv: 51 },
            b: { conv: 52, nonconv: 53 },
          }
        )
      end
      subject(:test_with_no_winner) { ABSplitTest.new(data_with_no_winner) }
      it "returns that there is no winner" do
        expect(test_with_no_winner.test_winner).to \
          eq("No winner at 0.05 significance")
      end
    end

    context "when B is winner" do
      let(:data_where_B_wins) do
        instance_double("ABDataSummary", a_conv: 54, a_nonconv: 55,
          b_conv: 102, b_nonconv: 56,
          to_h: {
            a: { conv: 54, nonconv: 55 },
            b: { conv: 102, nonconv: 56 },
          }
        )
      end
      subject(:test_where_B_wins) { ABSplitTest.new(data_where_B_wins) }
      it "returns that B is winner" do
        expect(test_where_B_wins.test_winner).to eq("B")
      end
    end
  end
end
