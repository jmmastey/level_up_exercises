class AddFlightNumberToFlights < ActiveRecord::Migration
  def change
    add_column :flights, :flight_number, :string
  end
end
