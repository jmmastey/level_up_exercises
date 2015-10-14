class RemoveAchievementIdFromActivity < ActiveRecord::Migration
  def change
    remove_column :activities, :achievement_id, :integer
  end
end
