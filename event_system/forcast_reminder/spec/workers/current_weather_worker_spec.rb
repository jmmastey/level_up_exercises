require 'rails_helper'

describe CurrentWeatherWorker, :type => :worker do
  before { Timecop.freeze(DateTime.now) }

  let (:model) { CurrentWeather }
  let (:worker) { CurrentWeatherWorker.new }


  describe "#perform" do
    let (:station_id) { 'KMDW' }
    let (:default_request_url) { "http://w1.weather.gov/xml/current_obs/KMDW.xml" }


    context "Default Request" do
      before do
        stub_request(:get, default_request_url).
          to_return(File.open("spec/workers/current_weather_worker_request_KMDW.txt"))
        worker.perform
      end

      subject { model.find_by_station_id(station_id) }


      let (:temperature) { 41 }
      let (:condition) { "Light Rain" }
      let (:location_name) { "Chicago Midway Airport, IL" }
      let (:observation_time) { "Last Updated on Nov 11 2014, 11:53 am CST" }
      let (:wind) { "West 15.0 mph" }
      let (:pressure) { 29.76 }
      let (:dew_point) { 37 }
      let (:wind_chill) { 33 }
      let (:visibility) { 10.00 }
      let (:humidity) { 86 }
      let (:icon_url) { "http://forecast.weather.gov/images/wtf/small/ra.png" }
      let (:history_url) { "http://www.weather.gov/data/obhistory/KMDW.html" }

      it "is expected to call service" do
        expect(a_request(:get, default_request_url)).to have_been_made
      end
      its(:station_id) { is_expected.to eq station_id }
      its(:temperature) { is_expected.to eq temperature }
      its(:condition) { is_expected.to eq condition }
      its(:location_name) { is_expected.to eq location_name }
      its(:observation_time) { is_expected.to eq observation_time }
      its(:wind) { is_expected.to eq wind }
      its(:pressure) { is_expected.to eq pressure }
      its(:dew_point) { is_expected.to eq dew_point }
      its(:wind_chill) { is_expected.to eq wind_chill }
      its(:visibility) { is_expected.to eq visibility }
      its(:humidity) { is_expected.to eq humidity }
      its(:icon_url) { is_expected.to eq icon_url }
      its(:history_url) { is_expected.to eq history_url }
    end

    context "Custom User Request" do
      let (:station_id) { 'KMKE' }
      let (:request_url) { 'http://w1.weather.gov/xml/current_obs/KMKE.xml' }
      subject { model.find_by_station_id(station_id) }

      before do
        @user = FactoryGirl.create(:user, station_id: station_id)
        stub_request(:get, default_request_url).
          to_return(File.open("spec/workers/current_weather_worker_request_KMDW.txt"))
        stub_request(:get, request_url).
          to_return(File.open("spec/workers/current_weather_worker_request_KMDW.txt"))
        worker.perform
      end

      it "is expected to call both urls" do
        expect(a_request(:get, default_request_url)).to have_been_made
        expect(a_request(:get, request_url)).to have_been_made
      end

      its(:station_id) { is_expected.to eq station_id }
    end

    context "Bad Station Request" do
      let (:station_id) { '12345' }
      let (:request_url) { 'http://w1.weather.gov/xml/current_obs/12345.xml' }
      subject { model.find_by_station_id(station_id) }

      before do
        @user = FactoryGirl.create(:user, station_id: station_id)
        stub_request(:get, default_request_url).
          to_return(File.open("spec/workers/current_weather_worker_request_KMDW.txt"))
        stub_request(:get, request_url).
          to_return(:status => [404, "Not Found"])
        worker.perform
      end

      it "is expected to call service" do
        expect(a_request(:get, request_url)).to have_been_made
      end
      it { is_expected.to be_nil }
    end
  end
end
