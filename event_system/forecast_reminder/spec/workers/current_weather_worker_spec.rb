require 'rails_helper'

vcr_options = { cassette_name: "current_weather", record: :none }
describe CurrentWeatherWorker, vcr: vcr_options, type: :worker do
  before do
    travel_to Time.new(2014, 11, 13, 12, 20, 00)
  end

  after { travel_back }

  let(:model) { CurrentWeather }
  let(:worker) { CurrentWeatherWorker.new }

  describe "#perform" do
    let(:default_request_url) do
      "http://w1.weather.gov/xml/current_obs/KMDW.xml"
    end

    context "Default Request" do
      before do
        worker.perform
      end

      let(:station_id) { 'KMDW' }
      let(:icon_url_match) do
        %r{http://forecast\.weather\.gov/images/wtf/small/.+\.png}
      end
      let(:history_url) do
        "http://www.weather.gov/data/obhistory/#{station_id}.html"
      end
      subject { model.find_by_station_id(station_id) }

      it "is expected to call service" do
        expect(a_request(:get, default_request_url)).to have_been_made
      end

      its(:station_id) { is_expected.to eq station_id }
      its(:temperature) { is_expected.to_not be_nil }
      its(:condition) { is_expected.to_not be_nil }
      its(:location_name) { is_expected.to_not be_nil }
      its(:observation_time) { is_expected.to_not be_nil }
      its(:wind) { is_expected.to_not be_nil }
      its(:pressure) { is_expected.to_not be_nil }
      its(:dew_point) { is_expected.to_not be_nil }
      its(:wind_chill) { is_expected.to_not be_nil }
      its(:visibility) { is_expected.to_not be_nil }
      its(:humidity) { is_expected.to_not be_nil }
      its(:icon_url) { is_expected.to match icon_url_match }
      its(:history_url) { is_expected.to eq history_url }
    end

    context "Custom User Request" do
      let(:station_id) { 'KMKE' }
      let(:request_url) do
        "http://w1.weather.gov/xml/current_obs/#{station_id}.xml"
      end
      let!(:user) { FactoryGirl.create(:user, station_id: station_id) }
      subject { model.find_by_station_id(station_id) }

      before do
        worker.perform
      end

      it "is expected to call both stations" do
        expect(a_request(:get, default_request_url)).to have_been_made
        expect(a_request(:get, request_url)).to have_been_made
      end

      it { is_expected.to_not be_nil }
      its(:station_id) { is_expected.to eq station_id }
    end

    context "Request with station_id" do
      let(:station_id) { 'KMKE' }
      let(:request_url) do
        "http://w1.weather.gov/xml/current_obs/#{station_id}.xml"
      end

      before do
        worker.perform(station_id)
      end

      it "is expected to call single station" do
        expect(a_request(:get, default_request_url)).to_not have_been_made
        expect(a_request(:get, request_url)).to have_been_made
      end
    end

    context "Bad Station Request" do
      let(:station_id) { '12345' }
      let(:request_url) do
        "http://w1.weather.gov/xml/current_obs/#{station_id}.xml"
      end
      let!(:user) { FactoryGirl.create(:user, station_id: station_id) }
      subject { model.find_by_station_id(station_id) }

      before do
        worker.perform
      end

      it "is expected to call service" do
        expect(a_request(:get, request_url)).to have_been_made
      end
      it { is_expected.to be_nil }
    end
  end
end
