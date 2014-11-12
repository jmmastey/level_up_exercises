require 'rails_helper'

describe CurrentWeatherWorker, :type => :worker do
  before { Timecop.freeze(DateTime.now) }

  let (:model) { CurrentWeather }
  let (:station_id) { 'KMDW' }
  let (:request_url) { 'http://w1.weather.gov/xml/current_obs/KMDW.xml' }
  let (:worker) { CurrentWeatherWorker.new }

  subject { model.find_by_station_id(station_id) }

  describe "#perform" do
    before do
      stub_request(:get, request_url).
        to_return(File.open("spec/workers/current_weather_worker_request_KMDW.txt"))
      worker.perform
    end

    context "New Request" do
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
  end
end
