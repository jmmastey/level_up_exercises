class ChangePrecipitationTypeInHourlyForecast < ActiveRecord::Migration
  def up
    change_column :hourly_forecasts, :precipitation, :float
  end

  def down
    change_column :hourly_forecasts, :precipitation, :int
  end
end
