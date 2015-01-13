require_relative '../cohort.rb'

describe Cohort do
  context "when views are a mixed" do
    let(:pageviews) { [PageView.new("A", 0), PageView.new("A", 1), PageView.new("A", 1)] }
    let(:pageviews_negative) { [PageView.new("B", 0), PageView.new("B", 0), PageView.new("B", 0), PageView.new("B", 0)] }
    let(:pageviews_positive) { [PageView.new("C", 1), PageView.new("C", 1)] }

#    let(:pageviews_positive) { [double(result: 1), double(result: 1)] }

    let(:cohort) { Cohort.new("A", pageviews) }
    let(:cohort_hated_it) { Cohort.new("B", pageviews_negative) }
    let(:cohort_loved_it) { Cohort.new("C", pageviews_positive) }

    it "has a name" do
      expect(cohort.name).to eq("A")
      expect(cohort_loved_it.name).to eq("C")
      expect(cohort_hated_it.name).to eq("B")
    end

    describe '#size' do
      it "counts the total views for a cohort" do
        expect(cohort.size).to eq(3)
        expect(cohort_loved_it.size).to eq(2)
        expect(cohort_hated_it.size).to eq(4)
      end
    end

    describe '#conversions' do
      it "counts the positives" do
        expect(cohort.conversions).to eq(2)
        expect(cohort_loved_it.conversions).to eq(2)
        expect(cohort_hated_it.conversions).to eq(0)
      end
    end

    describe '#rejections' do
      it "counts the negatives" do
        expect(cohort.rejections).to eq(1)
        expect(cohort_loved_it.rejections).to eq(0)
        expect(cohort_hated_it.rejections).to eq(4)
      end
    end

    describe '#conversion_percentage' do
      it "returns the correct value" do
        expect(cohort.conversion_percentage.round(4)).to eq(0.6667)
      end
    end

    describe '#standard_error' do
      it "returns the correct value" do
        expect(cohort.standard_error.round(4)).to eq(0.2722)
      end
    end
  end
end
