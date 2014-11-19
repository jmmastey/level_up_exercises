class AddDateDescriptionToForecasts < ActiveRecord::Migration
  def change
    add_column :forecasts, :date_description, :string
  end
end
