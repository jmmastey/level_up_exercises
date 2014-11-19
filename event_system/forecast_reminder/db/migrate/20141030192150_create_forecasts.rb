class CreateForecasts < ActiveRecord::Migration
  def change
    create_table :forecasts do |t|
      t.integer :zip_code
      t.datetime :date
      t.float :temperature
      t.string :condition
      t.integer :precipitation
      t.string :icon_url

      t.timestamps null: false
    end
  end
end
