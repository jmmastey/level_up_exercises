require 'savon'
require './app/models/api/weather_client'

def keys(hash)
  hash.each_with_object([]) do |(key, value), keys|
    keys << key
  end
end

describe WeatherClient do
  describe "for one lat lon point", vcr: { cassette_name: "one lat lon point",
                                           record: :new_episodes } do
    let(:client) { WeatherClient.new }
    let(:response) { client.request({ list_lat_lon: "41.837,-87.685",
                                          start_time:   "2015-01-30",
                                          end_time:     "2015-02-08" }) }
    let(:weather_data) { response.weather_data }

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

    it "returns expected attributes as arrays of 1 object" do
      attributes = [:locations,
                    :weather,
                    :temperatures,
                    :cloud_covers,
                    :conditions_icons]
      attributes.each do |attr|
        expect(weather_data.send(attr)).to be_an(Array)
        expect(weather_data.send(attr).count).to eq(1)
      end
    end

    it "returns locations with location_key, latitude, and longitude" do
      expect(weather_data.locations[0]).to respond_to(:location_key, :latitude, :longitude)
    end

    it "returns time_layouts as an array of at least 1 object" do
      expect(weather_data.time_layouts).to be_an(Array)
      expect(weather_data.time_layouts.count).to be > 0
    end

    it "returns time_layouts with layout_key, start_valid_time, end_valid_time" do
      expect(weather_data.time_layouts[0]).to respond_to(:layout_key,
                                                         :start_valid_time,
                                                         :end_valid_time)
    end

    # Some may be nil in the array
    it "returns some weather_conditions with expected attributes" do
      existing_conditions = weather_data.weather[0].weather_conditions.compact
      expect(existing_conditions[0]).to respond_to(:coverages,
                                                  :intensities,
                                                  :weather_types,
                                                  :qualifiers,
                                                  :additives)
    end

    it "returns temperatures with maxt and mint" do
      expect(weather_data.temperatures[0]).to respond_to(:maxt, :mint)
    end

    it "returns maxt with temperature type parameters" do
      expect(weather_data.temperatures[0].maxt).to respond_to(:name, :value, :type, :units, :time_layout)
    end

    it "returns mint with temperature type parameters" do
      expect(weather_data.temperatures[0].mint).to respond_to(:name, :value, :type, :units, :time_layout)
    end

    it "returns cloud cover with correct parameters" do
      expect(weather_data.cloud_covers[0]).to respond_to(:name, :value, :type, :units, :time_layout)
    end

    it "returns conditions icons with correct parameters" do
      expect(weather_data.conditions_icons[0]).to respond_to(:name, :icon_link, :type, :time_layout)
    end

    it "returns applicable locations that are one of the location_keys" do
      location_keys = weather_data.locations.each_with_object([]) do |location, keys| 
                        keys << location.location_key
                      end
      difference = weather_data.applicable_locations - location_keys
      expect(difference).to be_empty
    end
  end

  describe "for two lat lon points", vcr: { cassette_name: "two lat lon points",
                                           record: :new_episodes } do
    let(:client) { WeatherClient.new }
    let(:response) { client.request({ list_lat_lon: "41.837,-87.685 41.7918,-88.0878",
                                      start_time:   "2015-02-02",
                                      end_time:     "2015-02-10" }) }
    let(:weather_data) { response.weather_data }

    it "has the expected parameters nested under data" do
      parameters = [:location, :time_layout]
      parameters.each do |parameter|
        expect(weather_data.data).to have_key(parameter)
      end
    end

    it "has the expected parameters nested in both arrays under :parameters" do
      parameters = [:temperature,
                    :weather,
                    :cloud_amount,
                    :conditions_icon,
                    :@applicable_location]
      parameters.each do |parameter|
        expect(weather_data.data[:parameters][0]).to have_key(parameter)
        expect(weather_data.data[:parameters][1]).to have_key(parameter)
      end
    end

    it "returns expected attributes as arrays of 2 objects" do
      attributes = [:locations,
                    :weather,
                    :temperatures,
                    :cloud_covers,
                    :conditions_icons]
      attributes.each do |attr|
        expect(weather_data.send(attr)).to be_an(Array)
        expect(weather_data.send(attr).count).to eq(2)
      end
    end

    it "returns locations with location_key, latitude, and longitude" do
      expect(weather_data.locations[0]).to respond_to(:location_key, :latitude, :longitude)
      expect(weather_data.locations[1]).to respond_to(:location_key, :latitude, :longitude)
    end

    it "returns time_layouts as an array of at least 1 object" do
      expect(weather_data.time_layouts).to be_an(Array)
      expect(weather_data.time_layouts.count).to be > 0
    end

    it "returns time_layouts with layout_key, start_valid_time, end_valid_time" do
      expect(weather_data.time_layouts[0]).to respond_to(:layout_key, :start_valid_time, :end_valid_time)
      expect(weather_data.time_layouts[1]).to respond_to(:layout_key, :start_valid_time, :end_valid_time)
    end

    # Some may be nil in the array
    it "returns some weather_conditions with expected attributes" do
      existing_conditions = weather_data.weather[0].weather_conditions.compact
      expect(existing_conditions[0]).to respond_to(:coverages,
                                                  :intensities,
                                                  :weather_types,
                                                  :qualifiers,
                                                  :additives)
      existing_conditions = weather_data.weather[1].weather_conditions.compact
      expect(existing_conditions[1]).to respond_to(:coverages,
                                                  :intensities,
                                                  :weather_types,
                                                  :qualifiers,
                                                  :additives)
    end

    it "returns temperatures with maxt and mint" do
      expect(weather_data.temperatures[0]).to respond_to(:maxt, :mint)
      expect(weather_data.temperatures[1]).to respond_to(:maxt, :mint)
    end

    it "returns maxt with temperature type parameters" do
      expect(weather_data.temperatures[0].maxt).to respond_to(:name, :value, :type, :units, :time_layout)
      expect(weather_data.temperatures[1].maxt).to respond_to(:name, :value, :type, :units, :time_layout)
    end

    it "returns mint with temperature type parameters" do
      expect(weather_data.temperatures[0].mint).to respond_to(:name, :value, :type, :units, :time_layout)
      expect(weather_data.temperatures[1].mint).to respond_to(:name, :value, :type, :units, :time_layout)
    end

    it "returns cloud cover with correct parameters" do
      expect(weather_data.cloud_covers[0]).to respond_to(:name, :value, :type, :units, :time_layout)
      expect(weather_data.cloud_covers[1]).to respond_to(:name, :value, :type, :units, :time_layout)
    end

    it "returns conditions icons with correct parameters" do
      expect(weather_data.conditions_icons[0]).to respond_to(:name, :icon_link, :type, :time_layout)
      expect(weather_data.conditions_icons[1]).to respond_to(:name, :icon_link, :type, :time_layout)
    end

    it "returns applicable locations that are one of the location_keys" do
      location_keys = weather_data.locations.each_with_object([]) do |location, keys| 
                        keys << location.location_key
                      end
      difference = weather_data.applicable_locations - location_keys
      expect(difference).to be_empty
    end
  end
end
