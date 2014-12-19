class AddLocationForeignKeys < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        #add a foreign key
        execute <<-SQL
          ALTER TABLE airports
            ADD CONSTRAINT fk_airports_locations
            FOREIGN KEY (location_id)
            REFERENCES locations(id)
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE airports
            DROP CONSTRAINT fk_airports_locations
        SQL
      end
    end

    reversible do |dir|
      dir.up do
        #add a foreign key
        execute <<-SQL
          ALTER TABLE flights
            ADD CONSTRAINT fk_flights_origin
            FOREIGN KEY (origin_airport_id)
            REFERENCES airports(id)
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE flights
            DROP CONSTRAINT fk_flights_origin
        SQL
      end
    end

    reversible do |dir|
      dir.up do
        #add a foreign key
        execute <<-SQL
          ALTER TABLE flights
            ADD CONSTRAINT fk_flights_destination
            FOREIGN KEY (destination_airport_id)
            REFERENCES airports(id)
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE flights
            DROP CONSTRAINT fk_flights_destination
        SQL
      end
    end

    reversible do |dir|
      dir.up do
        #add a foreign key
        execute <<-SQL
          ALTER TABLE meetings
            ADD CONSTRAINT fk_meetings_locations
            FOREIGN KEY (location_id)
            REFERENCES locations(id)
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE airports
            DROP CONSTRAINT fk_meetings_locations
        SQL
      end
    end

    reversible do |dir|
      dir.up do
        #add a foreign key
        execute <<-SQL
          ALTER TABLE trips
            ADD CONSTRAINT fk_trips_home
            FOREIGN KEY (home_location_id)
            REFERENCES locations(id)
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE airports
            DROP CONSTRAINT fk_trips_home
        SQL
      end
    end
  end
end
