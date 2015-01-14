class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, limit: 256
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.text :description, limit: 1024
      t.string :event_hash, limit: 64
      t.string :family_hash, limit: 64
      t.string :location, limit: 256
      t.string :host, limit: 256

      t.timestamps
    end
  end
end
