require './app/models/api_data_transfer/point_loader'

ForecastType.create(forecast_type: "3-hour")
ForecastType.create(forecast_type: "24-hour")

# PointLoader.load("60606 60532")