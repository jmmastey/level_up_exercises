require './app/models/api_data_transfer/weather_loader'
require './app/models/api/weather_client'

def stub_client_return(return_value)
  expect_any_instance_of(WeatherClient).to receive(:request).and_return(return_value)
end

describe WeatherLoader do
  describe "for two lat lon points", vcr: { cassette_name: "two lat lon points",
                                           record: :new_episodes } do
    let(:params) { { list_lat_lon: "41.837,-87.685 41.7918,-88.0878",
                                      start_time:   "2015-02-02",
                                      end_time:     "2015-02-10" } }
    let(:client) { WeatherClient.new }
    let(:response) { client.request(params) }

    it "transfers data into the forecasts table" do
      stub_client_return(response)
      WeatherLoader.load(params)
      count = Forecast.count
      expect(count).to be > 0
    end

  end

end