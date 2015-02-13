require './app/models/api_data_transfer/weather_loader'
require './app/models/api/weather_client'

def stub_client_return(return_value)
  expect_any_instance_of(WeatherClient).to receive(:request).and_return(return_value)
end

describe WeatherLoader do

  let!(:params)   { { list_lat_lon: "41.837,-87.685 41.7918,-88.0878",
                                    start_time:   "2015-02-02",
                                    end_time:     "2015-02-10" } }
  let!(:client)   { WeatherClient.new }
  let!(:response) { client.request(params) }
  let!(:stub)     { stub_client_return(response) }
  let!(:loader)   { WeatherLoader.load(WeatherClient, params) }

  describe "for two lat lon points", vcr: { cassette_name: "two lat lon points",
                                           record: :new_episodes } do

    it "has 84 time periods, 42 for each point" do
      count = Forecast.count
      expect(count).to eq(84)
    end
  end

  # let!(:params)   { { list_lat_lon: "41.837,-87.685" } }
  # let!(:client)   { WeatherClient.new }
  # let!(:response) { client.request(params) }
  # let!(:stub)     { stub_client_return(response) }
  # let!(:loader)   { WeatherLoader.load(WeatherClient, params) }

  # describe "another data load from 8/13", vcr: { cassette_name: "one point for 8_13",
  #                                                record: :new_episodes } do
  #   it "has 42 time periods" do
  #     count = Forecast.count
  #     expect(count).to eq(42)
  #   end
  # end

    # describe "for a given 24 hour period" do
    #   it "has the right maxt in the database" do
    #     test = Forecast.daily.first

    #   end
    # end


end