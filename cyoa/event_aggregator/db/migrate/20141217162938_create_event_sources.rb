class CreateEventSources < ActiveRecord::Migration
  def change
    create_table :event_sources do |t|
      t.string :name
      t.string :source_type
      t.string :uri
      t.integer :frequency
      t.datetime :last_harvest

      t.timestamps
    end
  end
end
