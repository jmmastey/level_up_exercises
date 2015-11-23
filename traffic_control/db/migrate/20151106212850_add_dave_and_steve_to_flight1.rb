class AddDaveAndSteveToFlight1 < ActiveRecord::Migration
  def change
    Flight.find(1).passengers = [Passenger.find(1), Passenger.find(2)]
  end
end
