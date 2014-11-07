require 'rails_helper'

describe HourlyForecastWorker, :type => :worker do
  let (:model) { HourlyForecast.order(:date) }
  let (:test_url) { "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdXMLclient.php" }
  let (:test_query) { {"zipCodeList" => "60606", "product" => "time-series" } }
  subject { HourlyForecastWorker.new }

  describe "#perform" do
    before do
      stub_request(:get, test_url).with(query: test_query).
        to_return(File.open("spec/workers/hourly_forecast_request.txt"))
      subject.perform
    end

    context "New Request" do
      it "should call NWS unsummarized service" do
        expect(a_request(:get, test_url).
               with(query: test_query)).to have_been_made
      end

      it "should create 24 hours worth of data" do
        expect(model.count).to eq 24
      end
    end
  end
end
