class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :in_game_id
      t.references :locatable, polymorphic: true

      t.timestamps null: false
    end
  end
end
