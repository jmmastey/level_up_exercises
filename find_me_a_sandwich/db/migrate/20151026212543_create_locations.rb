class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.float :longitude
      t.float :latitude
      t.string :landmark

      t.timestamps null: false
    end
  end
end
