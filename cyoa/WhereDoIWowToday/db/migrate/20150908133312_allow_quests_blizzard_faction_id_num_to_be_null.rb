class AllowQuestsBlizzardFactionIdNumToBeNull < ActiveRecord::Migration
  def change
    change_column :quests, :blizzard_faction_id_num, :integer, null: true
  end
end
