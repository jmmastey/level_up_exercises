class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.decimal :lat, precision: 6, scale: 4, null: false
      t.decimal :lon, precision: 6, scale: 4, null: false
      t.string  :zip, limit: 20, null: false
      t.timestamps null: false
    end
  end
end
