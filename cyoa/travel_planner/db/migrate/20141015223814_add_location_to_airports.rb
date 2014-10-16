class AddLocationToAirports < ActiveRecord::Migration
  def change
    add_reference :airports, :location
  end
end
