class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.references :venue, index: true
      t.text :description, null: true
      t.string :price, null: true
      t.string :show_type, null: true
      t.string :phone_number, null: true
      t.string :running_time, null: true
      t.string :event_url, null: true
      t.string :ticket_url, null: true

      t.timestamps
    end
  end
end
