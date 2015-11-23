class CreateFlightPassengerJoinTable < ActiveRecord::Migration
  def change
    create_join_table :flights, :passengers do |t|
      t.index [:flight_id, :passenger_id]
      t.index [:passenger_id, :flight_id]
    end
  end
end
