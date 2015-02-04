class CreateWeatherTypes < ActiveRecord::Migration
  def change
    create_table :weather_types do |t|
      t.string :weather_type, null: false, unique: true
      t.timestamps            null: false
    end
  end
end
