require 'rails_helper'

describe HourlyForecastWorker, :type => :worker do
  # Freeze time so that the request and stub will match and not have jitters
  # if the request happens to be over a time period
  before { Timecop.freeze(Time.now) }

  let (:model) { HourlyForecast.order(:time) }
  let (:request_time) { Time.now }
  let (:zip_code) { 60606 }
  let (:test_url) { "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php" }
  let (:test_query) { {"zipCodeList" => zip_code, "product" => "time-series",
                       "begin" => request_time.iso8601, "temp" => "temp",
                       "dew" => "dew", "qpf" => "qpf", "sky" => "sky",
                       "wspd" => "wspd", "wdir" => "wdir", 'icons' => 'icons'} }
  let (:worker) { HourlyForecastWorker.new }
  subject { model.all }

  describe "#perform" do
    context "New Request" do
      let (:number_forecasts) { 9 }
      let (:temperatures) { [nil, 61, 56, 53, 53, 53, 48, 43, 41] }
      let (:dew_points) { [nil, 42, 42, 42, 42, 46, 42, 35, 32] }
      let (:precipitations) { [0.0, nil, 0.0, nil, 0.0, nil, 0.1, nil, 0.01] }
      let (:wind_speeds) { [nil, 17, 15, 14, 15, 13, 12, 16, 16] }
      let (:wind_directions) { [nil, 170, 180, 190, 200, 210, 240, 260, 280] }
      let (:cloud_cover) { [nil, 42, 34, 45, 77, 92, 96, 94, 92] }
      let (:icon_urls) { [nil,
                          "http://forecast.weather.gov/images/wtf/sct.jpg",
                          "http://forecast.weather.gov/images/wtf/nsct.jpg",
                          "http://forecast.weather.gov/images/wtf/nsct.jpg",
                          "http://forecast.weather.gov/images/wtf/nbkn.jpg",
                          "http://forecast.weather.gov/images/wtf/novc.jpg",
                          "http://forecast.weather.gov/images/wtf/nra20.jpg",
                          "http://forecast.weather.gov/images/wtf/ra70.jpg",
                          "http://forecast.weather.gov/images/wtf/rasn70.jpg"]
      }

      before do
        stub_request(:get, test_url).with(query: test_query).
          to_return(File.open("spec/workers/hourly_forecast_request.txt"))
        worker.perform
      end

      context "New Request" do
        it "is expected call NWS unsummarized service" do
          expect(a_request(:get, test_url).with(query: test_query)).
            to have_been_made
        end

        it "is expected create 24 hours worth of data" do
          expect(model.count).to eq number_forecasts
        end

        it "is expected to have correct temperatures" do
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
    end
  end
end
