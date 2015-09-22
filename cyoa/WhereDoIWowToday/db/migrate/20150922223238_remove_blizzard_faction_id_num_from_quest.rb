class RemoveBlizzardFactionIdNumFromQuest < ActiveRecord::Migration
  def change
    remove_column :quests, :blizzard_faction_id_num, :integer
  end
end
