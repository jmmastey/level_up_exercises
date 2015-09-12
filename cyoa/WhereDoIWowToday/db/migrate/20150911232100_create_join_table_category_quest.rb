class CreateJoinTableCategoryQuest < ActiveRecord::Migration
  def change
    create_join_table :categories, :quests do |t|
      # t.index [:category_id, :quest_id]
      # t.index [:quest_id, :category_id]
    end
  end
end
