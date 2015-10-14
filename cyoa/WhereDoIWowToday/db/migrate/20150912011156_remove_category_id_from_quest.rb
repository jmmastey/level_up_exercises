class RemoveCategoryIdFromQuest < ActiveRecord::Migration
  def change
    remove_column :quests, :category_id, :string
  end
end
