class ModifyForecastWeatherTypeConstraint < ActiveRecord::Migration
  def change
    # This index was unique, but the data is not necessarily unique.
    # There can be multiple of the same weather type for one forecast,
    # having a different coverage, but we are not confident enough to add
    # another unique constraint based on this which would cause the API refresh
    # to fail if violated.
    remove_index :forecast_weather_types, [:forecast_id, :weather_type_id]
    add_index :forecast_weather_types, [:forecast_id, :weather_type_id], unique: false
  end
end
