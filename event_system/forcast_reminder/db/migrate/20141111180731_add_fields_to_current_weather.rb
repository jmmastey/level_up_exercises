class AddFieldsToCurrentWeather < ActiveRecord::Migration
  def change
    add_column :current_weathers, :location_name, :string
    add_column :current_weathers, :observation_time, :string
    add_column :current_weathers, :wind, :string
    add_column :current_weathers, :pressure, :integer
    add_column :current_weathers, :dew_point, :integer
    add_column :current_weathers, :wind_chill, :integer
    add_column :current_weathers, :visiblity, :integer
    add_column :current_weathers, :icon_url, :string
    add_column :current_weathers, :history_url, :string
    rename_column :current_weathers, :conditions, :condition
  end
end
