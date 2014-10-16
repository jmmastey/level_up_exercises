class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :home_location_id

      t.timestamps
    end

    create_join_table :trips, :flights do |t|
      t.index :trip_id
    end

    create_join_table :trips, :meetings do |t|
      t.index :trip_id
    end

  end
end
