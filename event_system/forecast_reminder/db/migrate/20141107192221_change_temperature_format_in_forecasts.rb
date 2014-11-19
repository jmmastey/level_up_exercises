class ChangeTemperatureFormatInForecasts < ActiveRecord::Migration
  def change
    change_column :forecasts, :temperature, :integer
  end
end
