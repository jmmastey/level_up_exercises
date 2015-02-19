class CreateForecastTypes < ActiveRecord::Migration
  def change
    create_table :forecast_types do |t|
      t.string :forecast_type, null: false, unique: true
      t.timestamps             null: false
    end
  end
end
