require './app/models/point'
require './app/models/api_data_transfer/point_loader'
require './app/models/api/lat_lon_zipcode_client'

def stub_client_return(return_value)
  expect_any_instance_of(LatLonZipcodeClient).to receive(:request).and_return(return_value)
end

describe PointLoader do
  describe "for one point", vcr: { cassette_name: "one zip code" } do 
    it "transfers one point from the api to the model" do  
      stub_client_return({ "60606" => [41.837,-87.685] })
      PointLoader.load("60606")
      point = Point.where(lat: 41.837, lon: -87.685, zip: "60606").first
      expect(point.id).not_to be_nil
    end

    it "does not re-load an existing point" do
      stub_client_return({ "60606" => [41.837,-87.685] })
      PointLoader.load("60606")
      PointLoader.load("60606")
      count = Point.where(lat: 41.837, lon: -87.685, zip: "60606").count
      expect(count).to eq(1)
    end
  end

  describe "for two points", vcr: { cassette_name: "multiple zip codes" } do
    it "transfers two points from the api to the model" do
      stub_client_return({ "60606" => [41.837,-87.685],
                           "60532" => [41.7918,-88.0878] })
      PointLoader.load("60606 60532")
      count = Point.where(zip: ["60606","60532"]).count
      expect(count).to eq(2)
    end
  end  

  it "loads only all new non-existent points and ignores existing" do
    stub_client_return({ "60532" => [41.7918,-88.0878] })
    Point.new(zip: "60606", lat: 41.837, lon: -87.685).save
    PointLoader.load("60606 60532")
    count = Point.where(zip: ["60606","60532"]).count
    expect(count).to eq(2)
  end
end
