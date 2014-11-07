require 'rails_helper'

describe SummaryForecast, :type => :worker do
  let (:model) { Forecast.order(:date) }
  let (:summary_url) { "http://www.weather.gov/forecasts/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php" }
  let (:summary_query) { {"zipCodeList" => "60606", "format" => "12 hourly" } }
  subject { SummaryForecast.new }

  describe "#perform" do
    before do
      stub_request(:get, summary_url).with(query: summary_query).
        to_return(File.open("spec/workers/summary_forecast_request.txt"))
      subject.perform
    end

    context "New Request" do
      it "should call NWS summary service" do
        expect(a_request(:get, summary_url).
               with(query: summary_query)).to have_been_made
      end

      it "should create summery model" do
        expect(model.count).to eq 13
      end

      it "first max temperature should be correct" do
        expect(model.first.temperature).to eq 55
      end

      it "last min temperature should be correct" do
        expect(model.last.temperature).to eq 42
      end

      it "first precipitation should be correct" do
        expect(model.first.precipitation).to eq 48
      end

      it "last precipitation should be correct" do
        expect(model.last.precipitation).to eq 27
      end

      it "first condition should be correct" do
        expect(model.first.condition).to eq "Mostly Cloudy"
      end

      it "last condition should be correct" do
        expect(model.last.condition).to eq "Chance Rain Showers"
      end

      it "first condition icon should be correct" do
        expect(model.first.icon_url).to eq 'http://www.nws.noaa.gov/weather/images/fcicons/bkn.jpg'
      end

      it "last condition icon should be correct" do
        expect(model.last.icon_url).to eq 'http://www.nws.noaa.gov/weather/images/fcicons/hi_shwrs30.jpg'
      end

      it "first date description to be Tonight" do
        expect(model.first.date_description).to eq "Today"
      end
    end

    context "Update Request" do
      before do
        stub_request(:get, summary_url).with(query: summary_query).
          to_return(File.open("spec/workers/summary_forecast_update_request.txt"))
        subject.perform
      end

      it "is expected to add additional forecasts" do
        expect(model.count).to eq 15
      end

      it "is expected to have two today's" do
        expect(model.where(date_description: "Today").count).to eq 2
      end
    end
  end
end
