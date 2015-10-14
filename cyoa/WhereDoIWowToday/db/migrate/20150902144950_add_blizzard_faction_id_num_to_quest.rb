class AddBlizzardFactionIdNumToQuest < ActiveRecord::Migration
  def change
    add_column :quests, :blizzard_faction_id_num, :integer, null: false
  end
end
