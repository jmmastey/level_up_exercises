class RemoveLatitudeFromAirports < ActiveRecord::Migration
  def change
    remove_column :airports, :latitude, :decimal
  end
end
