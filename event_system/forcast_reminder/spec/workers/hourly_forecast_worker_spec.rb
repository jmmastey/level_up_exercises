require 'rails_helper'

vcr_options = { cassette_name: "hourly_forecast", record: :none }
describe HourlyForecastWorker, vcr: vcr_options, :type => :worker do
  # Freeze time so that the request and stub will match and not have jitters
  # if the request happens to be over a time period

  let (:model) { HourlyForecast.order(:time) }
  let (:request_time) { Time.now }
  let (:zip_code) { 60606 }
  let (:test_url) { "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php" }
  let (:test_query) { {"zipCodeList" => zip_code, "product" => "time-series",
                       "begin" => "2014-11-13T12:20:00-06:00", "temp" => "temp",
                       "dew" => "dew", "qpf" => "qpf", "sky" => "sky",
                       "wspd" => "wspd", "wdir" => "wdir", 'icons' => 'icons'} }
  let (:worker) { HourlyForecastWorker.new }

  describe "#perform" do
    before { travel_to Time.new(2014, 11, 13, 12, 20, 00) }
    after { travel_back }

    context "Default Request" do
      let (:number_forecasts) { 9 }
      let (:temperatures) { [nil, 30, 29, 27, 26, 25, 24, 25, 30] }
      let (:dew_points) { [nil, 14, 13, 15, 15, 15, 16, 16, 16] }
      let (:precipitations) { [0.0, nil, 0.0, nil, 0.0, nil, 0.0, nil, 0.0] }
      let (:wind_speeds) { [nil, 13, 11, 11, 10, 10, 9, 9, 8] }
      let (:wind_directions) { [nil, 290, 300, 300, 300, 290, 290, 290, 280] }
      let (:cloud_cover) { [nil, 94, 90, 92, 87, 82, 77, 64, 52] }
      let (:icon_urls) { 
        [
          nil,
          "http://forecast.weather.gov/images/wtf/sn60.jpg",
          "http://forecast.weather.gov/images/wtf/nsn60.jpg",
          "http://forecast.weather.gov/images/wtf/nsn10.jpg", 
          "http://forecast.weather.gov/images/wtf/nbkn.jpg",
          "http://forecast.weather.gov/images/wtf/nbkn.jpg",
          "http://forecast.weather.gov/images/wtf/nbkn.jpg",
          "http://forecast.weather.gov/images/wtf/bkn.jpg",
          "http://forecast.weather.gov/images/wtf/bkn.jpg",
        ]
      }
      
      subject { model.where(zip_code: zip_code).all }

      before do
        worker.perform
      end

      it "is expected call NWS unsummarized service" do
        expect(a_request(:get, test_url).with(query: test_query)).
          to have_been_made
      end

      its(:count) { is_expected.to eq number_forecasts }

      it "is expected to have correct temperatures" do
        binding
        expect(subject.map(&:temperature)).to eq temperatures
      end

      it "is expected to have correct dew points" do
        expect(subject.map(&:dew_point)).to eq dew_points
      end

      it "is expected to have correct precipitations" do
        expect(subject.map(&:precipitation)).to eq precipitations
      end

      it "is expected to have correct wind speed" do
        expect(subject.map(&:wind_speed)).to eq wind_speeds
      end

      it "is expected to have correct wind directions" do
        expect(subject.map(&:wind_direction)).to eq wind_directions
      end

      it "is expected to have correct cloud cover" do
        expect(subject.map(&:cloud_cover)).to eq cloud_cover
      end

      it "is expected to have correct condition icon urls" do
        expect(subject.map(&:icon_url)).to eq icon_urls
      end
    end

    context "Request with user" do
      let (:zip_code) { 53209 }
      let (:number_forecasts) { 9 }
      
      before do
        @user = FactoryGirl.create(:user, zip_code: zip_code)
        worker.perform
      end

      subject { model.where(zip_code: zip_code).all }

      it "is expected call NWS unsummarized service twice" do
        expect(a_request(:get, test_url).with(query: test_query)).
          to have_been_made
        new_query = test_query.merge({ "zipCodeList" => zip_code })
        expect(a_request(:get, test_url).with(query: new_query)).
          to have_been_made
      end

      its(:count) { is_expected.to eq number_forecasts }
    end
  end
end
