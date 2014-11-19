class RemoveDateDescriptionFromForecast < ActiveRecord::Migration
  def up
    remove_column :forecasts, :date_description
  end

  def down
    add_column :forecasts, :date_description, :string
  end
end
