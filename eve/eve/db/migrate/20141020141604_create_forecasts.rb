class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.date :target_date
      t.belongs_to :forecast_request

      t.timestamps null: false
    end
  end
end
