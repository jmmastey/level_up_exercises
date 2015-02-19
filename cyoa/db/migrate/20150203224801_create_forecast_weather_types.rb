class CreateForecastWeatherTypes < ActiveRecord::Migration
  def change
    create_table :forecast_weather_types do |t|
      t.integer :forecast_id,     null: false, foreign_key: true
      t.integer :weather_type_id, null: false, foreign_key: true
      t.string  :additive,        null: true,                    limit: 100
      t.string  :coverage,        null: true,                    limit: 100
      t.string  :qualifier,       null: true,                    limit: 100
      t.timestamps                null: false
    end
    add_index :forecast_weather_types, [:forecast_id, :weather_type_id], unique: true
  end
end
