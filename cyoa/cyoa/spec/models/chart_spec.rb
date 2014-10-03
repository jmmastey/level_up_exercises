require 'spec_helper'

describe Chart do
  let(:service) do
    service = Service.create(name: "facebook", url: "http://facebook.com")
    service.save
    service
  end

  subject(:chart) { service.charts.build(scope: "month") }

  it { should respond_to(:service) }
  it { should respond_to(:scope) }
  it { should be_valid }

  describe "#scope" do
    it "can only have type 'month' or 'day'" do
      chart.scope = "week"
      expect(chart).not_to be_valid

      chart.scope = "day"
      expect(chart).to be_valid
    end
  end

  describe "#service" do
    it "knows its service" do
      expect(chart.service).to eq(service)
    end

    it "must have a service" do
      chart.service = nil
      expect(chart).not_to be_valid
    end
  end
end
