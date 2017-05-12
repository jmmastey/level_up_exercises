class CreateEventDates < ActiveRecord::Migration
  def change
    create_table :event_dates do |t|
      t.references :venue, index: true
      t.datetime :date_time
      t.references :event, index: true

      t.timestamps
    end
  end
end
