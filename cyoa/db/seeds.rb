require './app/models/api_data_transfer/point_loader'

ForecastType.create(forecast_type: "3-hour")
ForecastType.create(forecast_type: "24-hour")
# PointLoader.load("60606 60532")
Point.create(lat: 41.8370, lon: -87.6850, zip: "60606")
Point.create(lat: 41.7918, lon: -88.0878, zip: "60532")
