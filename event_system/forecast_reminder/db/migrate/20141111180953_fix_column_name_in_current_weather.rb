class FixColumnNameInCurrentWeather < ActiveRecord::Migration
  def change
    rename_column :current_weathers, :visiblity, :visibility
  end
end
