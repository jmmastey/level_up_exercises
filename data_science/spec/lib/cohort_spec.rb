require 'spec_helper'
require 'cohort'

describe Cohort do
  let(:cohort) { Cohort.new(name: "A", size: 20, conversion_count: 10) }

  context "when it calculates its .conversion_rate_interval" do
    it "gets the right range" do
      expect(cohort.rate_min).to be_within(0.01).of(0.28)
      expect(cohort.rate_max).to be_within(0.01).of(0.72)
    end
  end

  context "when A is better than random" do
    context "when the difference is significant" do
      let(:a_sig_more) { Cohort.new(name: "A", size: 20, conversion_count: 18) }
      it ".better_than_random? is true" do
        expect(a_sig_more.better_than_random?).to be true
      end
      it "gets the right .confidence_of_significance percentage" do
        expect(a_sig_more.confidence_of_significance).to be_within(0.1).of(99.5)
      end
      it "is .significant?" do
        expect(a_sig_more.significant?).to be true
      end
      it "is .interesting?" do
        expect(a_sig_more.interesting?).to be true
      end
    end
    context "when the difference is not significant" do
      let(:insig_more) { Cohort.new(name: "A", size: 20, conversion_count: 15) }
      it "is .better_than_random?" do
        expect(insig_more.better_than_random?).to be true
      end
      it "gets the right .confidence_of_significance percentage" do
        expect(insig_more.confidence_of_significance).to be_within(0.1).of(89.8)
      end
      it "is .significant?" do
        expect(insig_more.significant?).to be false
      end
      it "is .interesting?" do
        expect(insig_more.interesting?).to be false
      end
    end
  end
  context "when A is NOT better than random" do
    let(:even_dist) { Cohort.new(name: "A", size: 20, conversion_count: 10) }
    it ".better_than_random? is false" do
      expect(even_dist.better_than_random?).to be false
    end

    it "is .significant?" do
      expect(even_dist.significant?).to be false
    end
    it "is .interesting?" do
      expect(even_dist.interesting?).to be false
    end
  end
end
