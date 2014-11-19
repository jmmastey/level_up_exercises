class RegistrationsController < Devise::RegistrationsController
  def sign_up(resource_name, resource)
    CurrentWeatherWorker.perform_async(resource.station_id)
    ForecastWorker.perform_async(resource.zip_code)
    super
  end
end
