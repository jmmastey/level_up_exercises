class AddFlight1ToFlights < ActiveRecord::Migration
  def change
    Flight.create!(
      departure_time: '2015-11-05 12:00:00',
      departure_airport: 'ORD',
      arrival_time: '2015-11-05 16:00:00',
      arrival_airport: 'LAX',
      plane: Plane.find(1)
    )
  end
end
