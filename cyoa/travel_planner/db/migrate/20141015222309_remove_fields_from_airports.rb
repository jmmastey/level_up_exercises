class RemoveFieldsFromAirports < ActiveRecord::Migration
  def change
    remove_column :airports, :longitude, :string
  end
end
