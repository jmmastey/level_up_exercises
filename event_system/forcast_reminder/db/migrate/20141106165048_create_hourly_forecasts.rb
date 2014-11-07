class CreateHourlyForecasts < ActiveRecord::Migration
  def change
    create_table :hourly_forecasts do |t|
      t.datetime :time
      t.float :temperature
      t.float :dew_point
      t.float :precipitation
      t.integer :wind_speed
      t.integer :wind_direction
      t.integer :cloud_cover
      t.string :hazard

      t.timestamps null: false
    end
  end
end
