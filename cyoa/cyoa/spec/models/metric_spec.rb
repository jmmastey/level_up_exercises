require "spec_helper"

describe Metric do
  let(:artist) do
    Artist.new(name: "Beyonce",
               grooveshark_id: 1234,
               nbs_id: 4321)
  end

  let(:service) { Service.new(name: "Grooveshark", url: "http://grooveshark.com") }
  let(:category) { Category.new(name: "fans") }

  subject(:metric) do
    Metric.new(artist: artist,
               service: service,
               category: category,
               value: 10)
  end

  it { is_expected.to be_valid }
  it { is_expected.to respond_to(:artist) }
  it { is_expected.to respond_to(:service) }
  it { is_expected.to respond_to(:category) }

  describe "associated with an artist and service" do
    it "must have an artist" do
      metric.save
      same_metric = metric.dup
      same_metric.artist = nil
      same_metric.save

      expect(same_metric).not_to be_valid
    end

    it "must have a service" do
      metric.save
      same_metric = metric.dup
      same_metric.service = nil
      same_metric.save

      expect(same_metric).not_to be_valid
    end
  end
end
