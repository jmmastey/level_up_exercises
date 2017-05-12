class CreateVenueEvents < ActiveRecord::Migration
  def change
    create_table :venue_events do |t|
      t.references :events, index: true
      t.references :event_dates, index: true
      t.references :venue, index: true

      t.timestamps
    end
  end
end
