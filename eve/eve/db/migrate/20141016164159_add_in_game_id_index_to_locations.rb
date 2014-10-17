class AddInGameIdIndexToLocations < ActiveRecord::Migration
  def change
    add_index :locations, :in_game_id, unique: true
  end
end
