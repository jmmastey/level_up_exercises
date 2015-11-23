class CreatePlaneTypes < ActiveRecord::Migration
  def change
    create_table :plane_types do |t|
      t.string :name
      t.integer :seat_count, limit: 3

      t.timestamps null: false
    end
  end
end
