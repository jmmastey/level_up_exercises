class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.references :venue, index: true
      t.text :description
      t.string :price
      t.string :show_type
      t.string :phone_number
      t.string :running_time
      t.string :event_url
      t.string :ticket_url

      t.timestamps
    end
  end
end
