class DropAchievementTable < ActiveRecord::Migration
  def change
    drop_table :achievements, force: :cascade
  end
end
