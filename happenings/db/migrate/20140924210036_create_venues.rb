class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :zipcode
      t.text :description
      t.string :phone_number
      t.string :url

      t.timestamps
    end
  end
end
