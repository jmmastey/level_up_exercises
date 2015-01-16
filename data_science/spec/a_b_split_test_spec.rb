require 'spec_helper'

describe ABSplitTest do
  context "when there is no clear A/B test winner" do
    let(:tallied_data) do
      instance_double(
        "ABDataSummary",
        a_conv: 50,
        a_nonconv: 51,
        b_conv: 52,
        b_nonconv: 53,
        to_h: { 
          a: {conv: 50, nonconv: 51},
          b: {conv: 52, nonconv: 53},
        }
      ) 
    end
    subject(:sample_calculator) { ABSplitTest.new(tallied_data) }
    describe "#confidence_level" do
      it "returns confidence_level" do
        expect(sample_calculator.confidence_level).to eq(0.002159)
      end
    end

    describe "#test_winner" do
      it "return that there is no clear winner" do
        expect(sample_calculator.test_winner).to \
          eq("No winner at 0.05 significance")
      end
    end

    describe "#test_winner" do
      it "prints stats for each cohort" do
        puts sample_calculator.to_s
      end
    end
  end

  context "when A cohort wins" do
    let(:tallied_data) do
      instance_double(
        "ABDataSummary",
        a_conv: 100,
        a_nonconv: 51,
        b_conv: 52,
        b_nonconv: 53,
        to_h: { 
          a: {conv: 100, nonconv: 51},
          b: {conv: 52, nonconv: 53},
        }
      ) 
    end
    subject(:sample_calculator) { ABSplitTest.new(tallied_data) }
    describe "#confidence_level" do
      it "returns confidence_level" do
        expect(sample_calculator.confidence_level).to eq(0.992553)
      end
    end

    describe "#test_winner" do
      it "return that A is winner" do
        expect(sample_calculator.test_winner).to \
          eq("A")
      end
    end

    describe "#test_winner" do
      it "prints stats for each cohort" do
        puts sample_calculator.to_s
      end
    end
  end

  context "when B cohort wins" do
    let(:tallied_data) do
      instance_double(
        "ABDataSummary",
        a_conv: 54,
        a_nonconv: 55,
        b_conv: 102,
        b_nonconv: 56,
        to_h: { 
          a: {conv: 54, nonconv: 55},
          b: {conv: 102, nonconv: 56},
        }
      ) 
    end
    subject(:sample_calculator) { ABSplitTest.new(tallied_data) }
    describe "#confidence_level" do
      it "returns confidence_level" do
        expect(sample_calculator.confidence_level).to eq(0.985591)
      end
    end

    describe "#test_winner" do
      it "return that A is winner" do
        expect(sample_calculator.test_winner).to \
          eq("B")
      end
    end

    describe "#test_winner" do
      it "prints stats for each cohort" do
        puts sample_calculator.to_s
      end
    end
  end
end
