class ChangePressureTypeInCurrentWeather < ActiveRecord::Migration
  def up
    change_column :current_weathers, :pressure, :float
  end

  def down
    change_column :current_weathers, :pressure, :integer
  end
end
