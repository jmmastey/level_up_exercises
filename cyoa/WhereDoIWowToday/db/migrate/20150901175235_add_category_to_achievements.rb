class AddCategoryToAchievements < ActiveRecord::Migration
  def change
    add_column :achievements, :category, :string
  end
end
