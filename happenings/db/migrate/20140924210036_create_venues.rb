class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address, null: true
      t.string :city, null: true
      t.string :zipcode, null: true
      t.text :description, null: true
      t.string :phone_number, null: true
      t.string :venue_url, null: true

      t.timestamps
    end
  end
end
