class AddStationIdToCurrentWeather < ActiveRecord::Migration
  def change
    add_column :current_weathers, :station_id, :string, unique: true, first: true
  end
end
