class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :code, limit: 3
      t.string :city, limit: 20
      t.integer :capacity

      t.timestamps null: false
    end
  end
end
