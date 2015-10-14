class RemoveBlizzardFactionIdNumFromCharacter < ActiveRecord::Migration
  def change
    remove_column :characters, :blizzard_faction_id_num, :integer
  end
end
