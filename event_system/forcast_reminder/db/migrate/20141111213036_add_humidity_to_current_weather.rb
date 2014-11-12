class AddHumidityToCurrentWeather < ActiveRecord::Migration
  def change
    add_column :current_weathers, :humidity, :integer
  end
end
