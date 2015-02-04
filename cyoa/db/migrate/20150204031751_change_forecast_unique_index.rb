class ChangeForecastUniqueIndex < ActiveRecord::Migration
  def change
    remove_index :forecasts, [:start_time, :end_time]
    add_index :forecasts, [:point_id, :start_time, :end_time], unique: true
  end
end
