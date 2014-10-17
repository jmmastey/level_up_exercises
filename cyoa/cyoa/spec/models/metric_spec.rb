require "spec_helper"

describe Metric do
  subject(:metric) { FactoryGirl.build(:metric) }

  it { is_expected.to be_valid }

  describe "#artist" do
    it { is_expected.to respond_to(:artist) }

    it "must have an artist" do
      expect(FactoryGirl.build(:metric, artist: nil)).not_to be_valid
    end
  end

  describe "#service" do
    it { is_expected.to respond_to(:service) }

    it "must have a service" do
      expect(FactoryGirl.build(:metric, service: nil)).not_to be_valid
    end
  end

  describe "#category" do
    it { is_expected.to respond_to(:category) }

    it "must have a category" do
      expect(FactoryGirl.build(:metric, category: nil)).not_to be_valid
    end
  end

  describe "#recorded_on" do
    it "must have a date" do
      expect(FactoryGirl.build(:metric, nbs_date: nil)).not_to be_valid
    end

    it "has recorded_on calculated on creation" do
      oct_12 = Time.new(2014, 10, 12, 12, 0, 0).to_i / (60 * 60 * 24)
      metric_oct_12 = FactoryGirl.create(:metric, nbs_date: oct_12.to_s)
      expect(metric_oct_12.recorded_on).to eq(Date.new(2014, 10, 12))
    end
  end
end
