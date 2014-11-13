require 'rails_helper'

vcr_options = { cassette_name: "summary_forecast", record: :new_episodes }
describe SummaryForecastWorker, vcr: vcr_options, type: :worker do
  let (:model) { Forecast.order(:date) }
  let (:zip_code) { 60606 }
  let (:test_url) { "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php" }
  let (:test_query) { {"zipCodeList" => zip_code, "format" => "12 hourly", 
                          "begin" => "2014-11-13T12:20:00-06:00" } }
  let (:worker) { SummaryForecastWorker.new }

  describe "#perform" do
    before do
      travel_to Time.new(2014, 11, 13, 12, 20, 00)
    end

    after { travel_back }

    context "New Forecasts" do
      let (:number_forecasts) { 13 }
      let (:temperatures) { [30, 24, 32, 22, 34, 29, 35, 23, 29, 20, 27, 21, 35] }
      let (:precipitations) { [56, 13, 3, 0, 9, 67, 23, 20, 13, 11, 9, 6, 5] }
      let (:conditions) do
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
        expect(a_request(:get, test_url).
               with(query: test_query)).to have_been_made
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

    context "Request with user" do
      let (:zip_code) { 53209 }
      let (:number_forecasts) { 13 }

      before do
        @user = FactoryGirl.create(:user, zip_code: zip_code)
        worker.perform
      end

      subject { model.where(zip_code: zip_code).all }

      it "is expected call NWS summarized service twice" do
        expect(a_request(:get, test_url).with(query: test_query)).
          to have_been_made
        new_query = test_query.merge({ "zipCodeList" => zip_code })
        expect(a_request(:get, test_url).with(query: new_query)).
          to have_been_made
      end

      its(:count) { is_expected.to eq number_forecasts }
    end

    #context "Update Request" do
    #before do
    #travel_to Time.new(2014, 11, 13, 12, 20, 00)
    #worker.perform
    #travel_to Time.new(2014, 11, 13, 13, 20, 00)
    #worker.perform
    #end

    #let (:number_forecasts) { 14 }
    #let (:temperatures) { [ 55, 41, 58, 46, 46, 35, 43, 38, 44, 31, 42, 35, 46, 32, 41 ] }

    #before do
    #worker.perform
    #end

    #it "is expected to have correct number of forecasts" do
    #expect(subject.count).to eq number_forecasts
    #end

    #it "is expected to have correct temperatures" do
    #expect(subject.map { |s| s.temperature }).to eq temperatures
    #end
    #end
  end
end
