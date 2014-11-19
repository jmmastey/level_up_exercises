class AddIconUrlToHourlyForecast < ActiveRecord::Migration
  def change
    add_column :hourly_forecasts, :icon_url, :string
  end
end
