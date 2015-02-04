class CreateWeatherForecasts < ActiveRecord::Migration
  def change
    create_table :weather_forecasts do |t|
      t.date :weather_day
      t.integer :high
      t.integer :low

      t.timestamps
    end
  end
end
