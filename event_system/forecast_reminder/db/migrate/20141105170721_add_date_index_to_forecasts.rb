class AddDateIndexToForecasts < ActiveRecord::Migration
  def change
    add_index :forecasts, :date, unique: true
  end
end
