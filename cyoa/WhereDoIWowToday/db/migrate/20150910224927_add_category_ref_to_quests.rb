class AddCategoryRefToQuests < ActiveRecord::Migration
  def change
    add_reference :quests, :category, index: true
    add_foreign_key :quests, :categories
  end
end
