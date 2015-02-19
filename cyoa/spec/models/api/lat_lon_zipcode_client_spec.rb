require 'savon'
require './app/models/api/lat_lon_zipcode_client'

describe LatLonZipcodeClient do
  describe "for one zip code", vcr: { cassette_name: "one zip code" } do
    let(:client) { LatLonZipcodeClient.new }
    let(:response) { client.request("60606") }
    it "has the lat_lon_list parameter in the response" do
      expect(response.response_parameters).to have_key(:lat_lon_list)
    end

    it "returns the expected latitude and longetude format" do
      expect(response.lat_lon_list).to match(/[\-]?\d{1,2}\.\d+,[\-]?\d{1,3}\.\d+( [\-]?\d{1,2}\.\d+,[\-]?\d{1,3}\.\d+)*/)
    end

    it "returns the correct latitude and longitude for one zipcode" do
      expect(response.lat_lon_list).to eq("41.837,-87.685")
    end

    it "returns the zip code with corresponding latitude and longetude" do
      expect(response.zip_code_lat_lon).to eq({ "60606" => [41.837,-87.685] })
    end
  end

  describe "for multiple zip codes", vcr: { cassette_name: "multiple zip codes" } do
    let(:client) { LatLonZipcodeClient.new }
    let(:response) { client.request("60606 60532") }
    it "has the lat_lon_list parameter in the response" do
      expect(response.response_parameters).to have_key(:lat_lon_list)
    end
    it "returns the expected latitude and longetude format" do
      expect(response.lat_lon_list).to match(/[\-]?\d{1,2}\.\d+,[\-]?\d{1,3}\.\d+( [\-]?\d{1,2}\.\d+,[\-]?\d{1,3}\.\d+)*/)
    end
    it "returns the correct latitude and longitude for multiple zipcodes" do
      expect(response.lat_lon_list).to eq("41.837,-87.685 41.7918,-88.0878")
    end

    it "returns the zip codes with corresponding latitude and longetude" do
      expect(response.zip_code_lat_lon).to eq({ "60606" => [41.837,-87.685],
                                                "60532" => [41.7918,-88.0878] })
    end
  end

  # Cassette only provided in case this mistakenly sends an API request (it shouldn't)
  describe "for invalid zip code format", vcr: { cassette_name: "invalid zip code format" } do
    let(:client) { LatLonZipcodeClient.new }
    it "should raise" do
      expect { client.request("606 60X32") }.to raise_error(LatLonZipcodeError)
    end
  end
end
