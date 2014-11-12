class ChangeVisibilityTypeInCurrentWeather < ActiveRecord::Migration
  def up
    change_column :current_weathers, :visibility, :float
  end

  def down
    change_column :current_weathers, :visibility, :integer
  end
end
