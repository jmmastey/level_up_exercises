require './app/models/api/weather_client'
require './app/models/api_data_transfer/time_key_builder'

describe TimeKeyBuilder do
  describe "for two lat lon points", vcr: { cassette_name: "two lat lon points",
                                           record: :new_episodes } do
    let(:client) { WeatherClient.new }
    let(:response) { client.request({ list_lat_lon: "41.837,-87.685 41.7918,-88.0878",
                                      start_time:   "2015-02-02",
                                      end_time:     "2015-02-10" }) }
    let(:weather_data) { response.weather_data }

    it "builds the time key" do
      time_key = TimeKeyBuilder.time_key(weather_data.time_layouts)
      expect(time_key).to be_kind_of(Hash)
      pp time_key
    end
  end
end