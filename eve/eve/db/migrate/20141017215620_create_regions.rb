class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.integer :in_game_id
      t.string :name

      t.timestamps null: false
    end

    add_index :regions, :in_game_id, unique: true
  end
end
