require './app/models/api_data_transfer/point_loader'

describe PointLoader do
  it "transfers data from the api to the model" do
    WeatherClient.any_instance.stub(:request)
    PointLoader.new("60606")
    point = Point.where(lat: 41.837, lon: -87.685, zipcode: "60606")
    expect(point.id).not_to be_nil
  end
end
