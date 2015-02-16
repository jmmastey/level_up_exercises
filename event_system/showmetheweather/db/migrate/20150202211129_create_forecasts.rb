class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.string :zip_code, limit: 5

      t.timestamps null: false
    end
  end
end
