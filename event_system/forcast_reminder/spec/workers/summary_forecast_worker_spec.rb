require 'rails_helper'

describe SummaryForecastWorker, :type => :worker do
  # Freeze time so that the request and stub will match and not have jitters
  # if the request happens to be over a time period
  before { Timecop.freeze(DateTime.now) }

  let (:model) { Forecast.order(:date) }
  let (:request_time) { DateTime.now }
  let (:zip_code) { 60606 }
  let (:summary_url) { "http://www.weather.gov/forecasts/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php" }
  let (:summary_query) { {"zipCodeList" => "60606", "format" => "12 hourly", 
                          "begin" => request_time.iso8601 } }
  let (:worker) { SummaryForecastWorker.new }
  subject { model.all }

  describe "#perform" do
    before do
      stub_request(:get, summary_url).with(query: summary_query).
        to_return(File.open("spec/workers/summary_forecast_request.txt"))
      worker.perform
    end

    context "New Forecasts" do
      let (:number_forecasts) { 13 }
      let (:temperatures) { [ 55, 41, 58, 45, 45, 35, 41, 36, 43, 30, 39, 33, 42 ] }
      let (:precipitations) { [ 48, 2, 6, 46, 59, 14, 6, 21, 41, 26, 13, 13, 27] }
      let (:conditions) do
        ["Mostly Cloudy", "Partly Cloudy", "Partly Sunny", 
         "Chance Rain Showers", "Rain Showers Likely", "Mostly Cloudy", 
         "Partly Sunny", "Slight Chance Rain Showers", "Chance Rain Showers",
         "Chance Rain/Snow", "Mostly Cloudy", "Mostly Cloudy",
         "Chance Rain Showers"]
      end

      it "is expected to call NWS summary service" do
        expect(a_request(:get, summary_url).
               with(query: summary_query)).to have_been_made
      end

      its(:count) { is_expected.to eq number_forecasts }

      it "is expected to have correct temperatures" do
        expect(subject.map { |s| s.temperature }).to eq temperatures
      end

      it "is expected to have correct precipitation data" do
        expect(subject.map { |s| s.precipitation }).to eq precipitations
      end

      it "is expected to have correct condition data" do
        expect(subject.map { |s| s.condition }).to eq conditions
      end

      it "is expected to have first date description equal Today" do
        expect(subject.first.date_description).to eq "Today"
      end
    end

    context "Update Request" do
      let (:number_forecasts) { 15 }
      let (:temperatures) { [ 55, 41, 58, 46, 46, 35, 43, 38, 44, 31, 42, 35, 46, 32, 41 ] }

      before do
        stub_request(:get, summary_url).with(query: summary_query).
          to_return(File.open("spec/workers/summary_forecast_update_request.txt"))
        worker.perform
      end

      it "is expected to have correct number of forecasts" do
        expect(subject.count).to eq number_forecasts
      end

      it "is expected to have two today's" do
        expect(model.where(date_description: "Today").count).to eq 2
      end

      it "is expected to have correct temperatures" do
        expect(subject.map { |s| s.temperature }).to eq temperatures
      end
    end
  end
end
