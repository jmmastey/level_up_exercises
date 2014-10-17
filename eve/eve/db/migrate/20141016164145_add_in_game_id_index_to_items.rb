class AddInGameIdIndexToItems < ActiveRecord::Migration
  def change
    add_index :items, :in_game_id, unique: true
  end
end
