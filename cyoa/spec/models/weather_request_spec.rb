require 'savon'
require './app/models/weather_request'

def keys(hash)
  hash.each_with_object([]) do |(key, value), keys|
    keys << key
  end
end

describe WeatherRequest do
  describe "for one lat lon point", vcr: { cassette_name: "one lat lon point",
                                           record: :new_episodes } do
    let(:request) { WeatherRequest.new({ list_lat_lon: "41.837,-87.685",
                                          start_time:   "2015-01-30",
                                          end_time:     "2015-02-08" }) }
    let(:weather_data) { request.response.weather_data }

    it "has the expected parameters nested under data" do
      parameters = [:location, :time_layout]
      parameters.each do |parameter|
        expect(weather_data.data).to have_key(parameter)
      end
    end

    it "has the expected parameters nested under :parameters" do
      parameters = [:temperature,
                    :weather,
                    :cloud_amount,
                    :conditions_icon,
                    :@applicable_location]
      parameters.each do |parameter|
        expect(weather_data.data[:parameters]).to have_key(parameter)
      end
    end

    it "returns locations as an array of 1 object" do
      expect(weather_data.locations).to be_an(Array)
      expect(weather_data.locations.count).to eq(1)
    end

    it "returns locations with location_key, latitude, and longitude" do
      expect(weather_data.locations[0]).to respond_to(:location_key, :latitude, :longitude)
    end

    it "returns time_layouts as an array of 1 object" do
      expect(weather_data.time_layouts).to be_an(Array)
      expect(weather_data.locations.count).to eq(1)
    end

    it "returns time_layouts with layout_key, start_valid_time, end_valid_time" do
      expect(weather_data.time_layouts[0]).to respond_to(:layout_key,
                                                         :start_valid_time,
                                                         :end_valid_time)
    end
  end

  describe "for two lat lon points", vcr: { cassette_name: "two lat lon points",
                                           record: :new_episodes } do
    let(:request) { WeatherRequest.new({ list_lat_lon: "41.837,-87.685 41.7918,-88.0878",
                                          start_time:   "2015-02-02",
                                          end_time:     "2015-02-10" }) }
    it "has a response" do
    end
  end
end
