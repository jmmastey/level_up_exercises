require "spec_helper"

describe Metric do
  let(:service) { Service.new(name: "Grooveshark", url: "http://grooveshark.com") }

  subject(:metric) do
    Metric.new(artist: FactoryGirl.create(:beyonce),
               json_data: "{\"metric\":\"facebook\"}",
               start_on: 2.months.ago,
               end_on: Today,
               service: service)
  end

  it { is_expected.to be_valid }
  it { is_expected.to respond_to(:artist) }
  it { is_expected.to respond_to(:service) }

  describe "associated with an artist and service" do
    it "must have an artist" do
      metric.save
      same_metric = metric.dup
      same_metric.artist = nil
      same_metric.save

      expect(same_metric).not_to be_valid
    end
  end
end
