class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :venue_id
      t.string :name
      t.string :street
      t.integer :distance
      t.decimal :rating
      t.string :url
      t.string :category_name
      t.string :category_icon_prefix
      t.string :category_icon_suffix

      t.timestamps null: false
    end
    add_index :venues, :venue_id, unique: true
  end
end
