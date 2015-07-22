require 'spec_helper'
require 'cohort'

describe Cohort do
  context "when it calculates its .conversion_rate_interval" do
    let(:cohort) { Cohort.new(name: "A", size: 20, conversion_count: 10) }
    it "gets the right range" do
      expect(cohort.rate_min).to be_within(0.01).of(0.28)
      expect(cohort.rate_max).to be_within(0.01).of(0.72)
    end
  end

  context "when A is better than B" do
    let(:cohort_b) { Cohort.new(name: "B", size: 20, conversion_count: 10) }
    context "when the difference is significant" do
      let(:a_sig_more) { Cohort.new(name: "A", size: 20, conversion_count: 18) }
      it "is .better_than? B" do
        expect(a_sig_more.better_than?(cohort_b)).to be true
      end
      it "gets the right .significance_of_difference percentage" do
        significance = a_sig_more.significance_of_difference(cohort_b)
        expect(significance).to be_within(0.1).of(99.5)
      end
      it "correctly converts itself .to_s" do
        description = "Cohort A contains 20 samples with 18 conversions.  The "
        description << "conversion rate is 77% - 100% with a 95% confidence."
        expect(a_sig_more.to_s).to eq(description)
      end
    end
    context "when the difference is not significant" do
      let(:insig_more) { Cohort.new(name: "A", size: 20, conversion_count: 15) }
      it "is .better_than?" do
        expect(insig_more.better_than?(cohort_b)).to be true
      end
      it "gets the right .significance_of_difference percentage" do
        significance = insig_more.significance_of_difference(cohort_b)
        expect(significance).to be_within(0.1).of(89.8)
      end
    end
  end
  context "when A is NOT better than B" do
    let(:even_dist) { Cohort.new(name: "A", size: 20, conversion_count: 10) }
    let(:cohort_b) { Cohort.new(name: "B", size: 20, conversion_count: 10) }
    it ".better_than? is false" do
      expect(even_dist.better_than?(cohort_b)).to be false
    end
    it "correctly converts itself .to_s" do
      description = "Cohort A contains 20 samples with 10 conversions.  "
      description << "The conversion rate is 28% - 72% with a 95% confidence."
      expect(even_dist.to_s).to eq(description)
    end
  end
end
