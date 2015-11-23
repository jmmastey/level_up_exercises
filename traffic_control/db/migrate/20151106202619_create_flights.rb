class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.references :plane, index: true, foreign_key: true
      t.datetime :departure_time
      t.string :departure_airport, limit: 3
      t.datetime :arrival_time
      t.string :arrival_airport, limit: 3

      t.timestamps null: false
    end
  end
end
