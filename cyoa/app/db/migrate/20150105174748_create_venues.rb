class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues, id: false do |t|
      t.primary_key :id
      t.string :name
      t.string :address
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end
