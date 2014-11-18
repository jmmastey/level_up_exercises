require 'rails_helper'

vcr_options = { cassette_name: "forecast", record: :none }
describe ForecastWorker, vcr: vcr_options, type: :worker do
  let(:model) { Forecast.order(:time) }
  let(:zip_code) { 60606 }
  let(:test_url) { "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php" }
  let(:test_query) do
    {
      "zipCodeList" => zip_code, "format" => "12 hourly",
      "begin" => "2014-11-13T12:20:00-06:00"
    }
  end
  let(:worker) { ForecastWorker.new }

  describe "#perform" do
    before do
      travel_to Time.new(2014, 11, 13, 12, 20, 00)
    end

    after { travel_back }

    context "New Forecasts" do
      let(:number_forecasts) { 13 }
      let(:temperatures) { [30, 24, 32, 22, 34, 29, 35, 23, 29, 20, 27, 21, 35] }
      let(:precipitations) { [56, 13, 3, 0, 9, 67, 23, 20, 13, 11, 9, 6, 5] }
      let(:conditions) do
        ["Flurries", "Cloudy", "Mostly Cloudy", "Mostly Clear", "Partly Sunny",
         "Snow Likely", "Slight Chance Snow", "Slight Chance Snow",
         "Mostly Cloudy", "Mostly Cloudy", "Mostly Cloudy", "Mostly Cloudy",
         "Partly Sunny"]
      end

      subject { model.all }

      before do
        worker.perform
      end

      it "is expected to call NWS summary service" do
        expect(a_request(:get, test_url)
          .with(query: test_query)).to have_been_made
      end

      its(:count) { is_expected.to eq number_forecasts }

      it "is expected to have correct data" do
        expect(subject.map(&:temperature)).to eq temperatures
        expect(subject.map(&:precipitation)).to eq precipitations
        expect(subject.map(&:condition)).to eq conditions
      end
    end

    context "Request with user" do
      let(:zip_code) { 53209 }
      let(:number_forecasts) { 13 }

      before do
        @user = FactoryGirl.create(:user, zip_code: zip_code)
        worker.perform
      end

      subject { model.where(zip_code: zip_code).all }

      it "is expected call NWS summarized service twice" do
        expect(a_request(:get, test_url).with(query: test_query))
          .to have_been_made
        new_query = test_query.merge("zipCodeList" => zip_code)
        expect(a_request(:get, test_url).with(query: new_query))
          .to have_been_made
      end

      its(:count) { is_expected.to eq number_forecasts }
    end

    context "Update Request" do
      before do
        travel_to Time.new(2014, 11, 13, 12, 20, 00)
        worker.perform
        travel_to Time.new(2014, 11, 14, 13, 20, 00)
        worker.perform
      end

      let(:number_forecasts) { 15 }
      let(:temperatures) { [30, 24, 30, 21, 32, 26, 33, 21, 27, 16, 25, 19, 35, 26, 39] }
      subject { model.all }

      before do
        worker.perform
      end

      it "is expected to have correct number of forecasts" do
        expect(subject.count).to eq number_forecasts
      end

      it "is expected to have correct temperatures" do
        expect(subject.map(&:temperature)).to eq temperatures
      end
    end
  end
end
