class AddOrdAndLaxToAirports < ActiveRecord::Migration
  def change
    Airport.create!(code: 'ORD', city: 'Chicago', capacity: 5)
    Airport.create!(code: 'LAX', city: 'Los Angeles', capacity: 3)
  end
end
