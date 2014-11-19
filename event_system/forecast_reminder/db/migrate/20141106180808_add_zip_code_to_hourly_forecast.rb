class AddZipCodeToHourlyForecast < ActiveRecord::Migration
  def change
    add_column :hourly_forecasts, :zip_code, :int, first: true
  end
end
