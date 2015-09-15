class QuestsTitleAndBlizzardIdNumNotNull < ActiveRecord::Migration
  def change
    change_column_null :quests, :title, false
    change_column_null :quests, :blizzard_id_num, false
  end
end
