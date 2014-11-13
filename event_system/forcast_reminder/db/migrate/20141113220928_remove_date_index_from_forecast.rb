class RemoveDateIndexFromForecast < ActiveRecord::Migration
  def change
    remove_index :forecasts, :date
  end
end
