class RemoveZipCodeFromCurrentWeather < ActiveRecord::Migration
  def change
    remove_column :current_weathers, :zip_code, :integer
  end
end
