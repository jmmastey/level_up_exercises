require "spec_helper"

describe Metric do
  subject(:metric) { FactoryGirl.create(:metric) }

  it { is_expected.to be_valid }
  it { is_expected.to respond_to(:artist) }
  it { is_expected.to respond_to(:service) }
  it { is_expected.to respond_to(:category) }

  describe "#validations" do
    it "must have an artist" do
      metric.artist = nil
      expect(metric).not_to be_valid
    end

    it "must have a service" do
      metric.service = nil
      expect(metric).not_to be_valid
    end

    it "must have a category" do
      metric.category = nil
      expect(metric).not_to be_valid
    end

    it "must have a date" do
      metric.nbs_date = nil
      expect(metric).not_to be_valid
    end
  end

  it "has recorded_on calculated on creation" do
    oct_12 = Time.new(2014, 10, 12, 12, 0, 0).to_i / (60 * 60 * 24)
    metric_oct_12 = FactoryGirl.create(:metric, nbs_date: oct_12.to_s) 
    expect(metric_oct_12.recorded_on).to eq(Date.new(2014, 10, 12))
    expect(Metric.last.recorded_on).to eq(Date.new(2014, 10, 12))
  end
end
