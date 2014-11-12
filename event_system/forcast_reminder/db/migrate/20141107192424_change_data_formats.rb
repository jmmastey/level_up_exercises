class ChangeDataFormats < ActiveRecord::Migration
  def change
    change_column :current_weathers, :temperature, :integer
    change_column :hourly_forecasts, :temperature, :integer
    change_column :hourly_forecasts, :dew_point, :integer
    change_column :hourly_forecasts, :precipitation, :integer
  end
end
