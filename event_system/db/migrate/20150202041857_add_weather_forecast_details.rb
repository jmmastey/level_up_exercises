class AddWeatherForecastDetails < ActiveRecord::Migration
  def change
    create_table :weather_forecast_details, primary_key: :id do |t|
      t.date :weather_day
      t.text :detail_afternoon
      t.text :detail_night

      t.timestamps
    end
  end
end
