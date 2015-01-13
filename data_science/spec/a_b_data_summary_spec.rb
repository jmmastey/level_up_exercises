require 'spec_helper'

describe ABDataSummary do
  Dir.chdir("./spec")
  describe "#new" do
    context "with invalid input" do
      it "returns exception for empty files" do
        expect { ABDataSummary.new("empty.json") }.to raise_error
      end

      it "returns exception with only one data point" do
        expect { ABDataSummary.new("one_data_point.json") }.to raise_error
      end

      it "returns exception if cohort is not A or B" do
        expect { ABDataSummary.new("data_with_c_cohort.json") }.to raise_error
      end

      it "returns exception if result is not 1 or 0" do
        expect { ABDataSummary.new("invalid_results.json") }.to raise_error
      end

      it "returns exception if only A or B data is present" do
        expect { ABDataSummary.new("no_b_cohort.json") }.to raise_error
      end

      it "returns exception when given file is not json data" do
        puts ABDataSummary.new("README.md")
        expect { ABDataSummary.new("../README.md") }.to raise_error
      end
    end

    context "with valid input" do
      let(:source_summary) { ABDataSummary.new("sample_valid_input.json") }
      it "returns conversion data for A and B cohorts" do
        expect(source_summary.a_conv).to eq(3)
        expect(source_summary.a_nonconv).to eq(3)
        expect(source_summary.b_conv).to eq(4)
        expect(source_summary.b_nonconv).to eq(1)
      end
    end
  end
end
