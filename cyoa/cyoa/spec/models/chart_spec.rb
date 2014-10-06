require 'spec_helper'

describe Chart do
  let(:service) do
    service = Service.create(name: "facebook", url: "http://facebook.com")
    service.save
    service
  end

  subject(:chart) { service.charts.build(scope: "monthly") }

  it { is_expected.to be_valid }

  it { is_expected.to respond_to(:scope) }
  it { is_expected.to respond_to(:songs) }
  it { is_expected.to respond_to(:artists) }

  describe "#scope" do
    it "can only have type 'monthly' or 'daily'" do
      chart.scope = "weekly"
      expect(chart).not_to be_valid

      chart.scope = "daily"
      expect(chart).to be_valid
    end
  end
end
