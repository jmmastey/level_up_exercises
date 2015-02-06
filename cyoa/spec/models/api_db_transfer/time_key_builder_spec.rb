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
    let(:times) { TimeKeyBuilder.times(weather_data.time_layouts) }
    it "builds the time key" do
      expect(times).to be_kind_of(Hash)
    end

    it "has expected keys in each hash" do
      expect(times.keys[0]).to have_key(:forecast_id)
      expect(times.keys[0]).to have_key(:start_time)
      expect(times.keys[0]).to have_key(:end_time)
      binding.pry
    end
  end
end