class RenameDateColumnInForecasts < ActiveRecord::Migration
  def change
    rename_column :forecasts, :date, :time
  end
end
