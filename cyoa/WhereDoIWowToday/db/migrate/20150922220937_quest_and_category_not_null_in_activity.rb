class QuestAndCategoryNotNullInActivity < ActiveRecord::Migration
  def change
    change_column :activities, :quest_id, :integer, null: false
    change_column :activities, :category_id, :integer, null: false
  end
end
