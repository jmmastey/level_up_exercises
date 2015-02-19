class AddForecastTypeIdToForecasts < ActiveRecord::Migration
  def change
    add_column :forecasts, :forecast_type_id, :integer, foreign_key: true
  end
end
