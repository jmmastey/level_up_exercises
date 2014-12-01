class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.belongs_to :destination_airport
      t.belongs_to :origin_airport
      t.datetime :origin_date_time
      t.datetime :destination_date_time

      t.timestamps
    end
  end
end
