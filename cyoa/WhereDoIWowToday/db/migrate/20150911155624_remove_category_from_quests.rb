class RemoveCategoryFromQuests < ActiveRecord::Migration
  def change
    remove_column :quests, :category, :string
  end
end
