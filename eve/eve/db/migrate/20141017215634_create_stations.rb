class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :in_game_id
      t.string :name

      t.timestamps null: false
    end

    add_index :stations, :in_game_id, unique: true
  end
end
