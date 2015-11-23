class AddDaveAndSteveToPassengers < ActiveRecord::Migration
  def change
    Passenger.create!(name: 'Dave', seating_preference: 'Window', meal_preference: 'Meat')
    Passenger.create!(name: 'Steve', seating_preference: 'Aisle', meal_preference: 'Vegan')
  end
end
