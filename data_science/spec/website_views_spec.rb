require 'spec_helper'
require_relative '../website_views.rb'

describe WebsiteViews do
  let(:website_views) { WebsiteViews.new("sample.json") }

  describe '#initialize' do
    it "should assign cohort_A and cohort_B" do
      expect(website_views.cohort_A.is_a?(Cohort)).to be true
      expect(website_views.cohort_B.is_a?(Cohort)).to be true
    end
  end

  describe '#true_confidence_level?' do
    it "should return true when difference is < 0.05" do
      expect(website_views.true_confidence_level?).to be true
    end

    it "should return false when difference is > 0.05" do
      website_views = WebsiteViews.new("false_sample.json")
      expect(website_views.true_confidence_level?).to be false
    end
  end
end
