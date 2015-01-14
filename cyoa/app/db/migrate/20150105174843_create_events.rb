class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events, id: false do |t|
      t.primary_key :id
      t.float :avg_price
      t.float :low_price
      t.string :title
      t.string :picture, :default => "ticket.jpg"
      t.string :link
      t.integer :listings
      t.integer :venue_id
      t.date :date

      t.timestamps
    end
  end
end
