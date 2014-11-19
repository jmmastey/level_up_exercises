require 'rails_helper'

vcr_options = { cassette_name: "forecast", record: :none }
describe ForecastWorker, vcr: vcr_options, type: :worker do
  let(:model) { HourlyForecast.order(:time) }
  let(:request_time) { Time.now }
  let(:zip_code) { 60606 }
  let(:test_url) do
    "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php"
  end
  let(:test_query) do
    {
      "zipCodeList" => zip_code, "product" => "time-series",
      "begin" => "2014-11-13T12:20:00-06:00", "temp" => "temp",
      "dew" => "dew", "qpf" => "qpf", "sky" => "sky",
      "wspd" => "wspd", "wdir" => "wdir", 'icons' => 'icons'
    }
  end
  let(:worker) { ForecastWorker.new }

  describe "#perform" do
    before { travel_to Time.new(2014, 11, 13, 12, 20, 00) }
    after { travel_back }

    context "Default Request" do
      let(:number_forecasts) { 8 }
      let(:icon_match) { %r{http://forecast\.weather\.gov/images/wtf/.+\.jpg} }
      subject { model.where(zip_code: zip_code).all }

      before do
        worker.perform
      end

      it "is expected call NWS unsummarized service" do
        expect(a_request(:get, test_url).with(query: test_query))
          .to have_been_made
      end

      its(:count) { is_expected.to eq number_forecasts }

      it "is expected to have correct data" do
        binding
        expect(subject.map(&:temperature)).to all(be_an(Numeric))
        expect(subject.map(&:dew_point)).to all(be_an(Numeric))
        expect(subject.map(&:precipitation)).to include(be_an(Numeric))
        expect(subject.map(&:wind_speed)).to all(be_an(Numeric))
        expect(subject.map(&:wind_direction)).to all(be_an(Numeric))
        expect(subject.map(&:cloud_cover)).to all(be_an(Numeric))
        expect(subject.map(&:icon_url)).to all(match(icon_match))
      end
    end

    context "Request with user" do
      let(:zip_code) { 53209 }
      let(:number_forecasts) { 8 }
      subject { model.where(zip_code: zip_code).all }

      before do
        @user = FactoryGirl.create(:user, zip_code: zip_code)
        worker.perform
      end

      it "is expected call NWS unsummarized service twice" do
        expect(a_request(:get, test_url).with(query: test_query))
          .to have_been_made
        new_query = test_query.merge("zipCodeList" => zip_code)
        expect(a_request(:get, test_url).with(query: new_query))
          .to have_been_made
      end

      its(:count) { is_expected.to eq number_forecasts }
    end
  end
end
