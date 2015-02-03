require './app/models/point'
require './app/models/api_data_transfer/point_loader'
require './app/models/api/lat_lon_zipcode_client'

describe PointLoader do
  it "transfers data from the api to the model" do
    LatLonZipcodeClient.any_instance.stub(:request).and_return({ "60606" => [41.837,-87.685] })
    PointLoader.load("60606")
    point = Point.where(lat: 41.837, lon: -87.685, zipcode: "60606")
    expect(point.id).not_to be_nil
  end
end
